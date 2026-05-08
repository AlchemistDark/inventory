import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying the list of positions with CRUD operations
class PositionsPage extends StatelessWidget {
  /// Creates a [PositionsPage]
  const PositionsPage({super.key});

  static void _showPositionForm(BuildContext context, [PositionEntity? position]) {
    Navigator.push<void>(
      context,
      PositionFormPage.route(position: position),
    );
  }

  static Future<void> _confirmDelete(BuildContext context, PositionEntity position) async {
    final l10n = AppLocalizations.of(context)!;
    final positionsBloc = context.read<PositionsBloc>();

    final confirmed = await AppDialogs.showDeleteConfirmation(
      context: context,
      entityName: position.name,
      entityTypeLabel: l10n.common_position,
    );

    if (confirmed == true) {
      positionsBloc.add(DeletePositionEvent(position.id));
    }
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
