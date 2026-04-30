import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying the list of positions with CRUD operations
class PositionsPage extends StatelessWidget {
  /// Creates a [PositionsPage]
  const PositionsPage({super.key});

  void _showPositionForm(BuildContext context, [PositionEntity? position]) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => PositionFormDialog(
        position: position,
        onSave: (name) {
          final newPosition = PositionEntity(
            id: position?.id ?? 0,
            name: name,
            createdAt: position?.createdAt ?? DateTime.now(),
          );
          if (position == null) {
            context.read<PositionsBloc>().add(CreatePositionEvent(newPosition));
          } else {
            context.read<PositionsBloc>().add(UpdatePositionEvent(newPosition));
          }
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                position == null
                    ? l10n.positions_created
                    : l10n.positions_updated,
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, PositionEntity position) {
    final l10n = AppLocalizations.of(context)!;

    final nameLabel = l10n.positions_nameLabel;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
            l10n.common_deleteConfirmTitle(nameLabel)),
        content: Text(l10n.common_deleteConfirmContent(position.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.common_cancel),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<PositionsBloc>()
                  .add(DeletePositionEvent(position.id));
              Navigator.pop(dialogContext);
            },
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            child: Text(l10n.common_delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home_positionsButton),
      ),
      body: BlocBuilder<PositionsBloc, PositionsState>(
        builder: (context, state) {
          if (state is PositionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PositionsLoaded) {
            if (state.positions.isEmpty) {
              return Center(child: Text(l10n.positions_emptyList));
            }

            return PositionList(
              positions: state.positions,
              onDelete: (PositionEntity position) =>
                  _confirmDelete(context, position),
              onTap: (PositionEntity position) =>
                  _showPositionForm(context, position),
            );
          } else if (state is PositionsError) {
            return Center(
                child: Text(l10n.common_error(state.failure.toLocalizedString(l10n))));
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPositionForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
