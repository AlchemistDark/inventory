
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying the list of rooms with CRUD operations
class RoomsPage extends StatelessWidget {
  /// Creates a [RoomsPage]
  const RoomsPage({super.key});

  void _showRoomForm(BuildContext context, [RoomEntity? room]) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => RoomFormPage(room: room),
      ),
    );
  }

  void _confirmDelete(BuildContext context, RoomEntity room) {
    final l10n = AppLocalizations.of(context)!;

    final nameLabel = l10n.rooms_nameLabel;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
            l10n.common_deleteConfirmTitle(nameLabel)),
        content: Text(l10n.common_deleteConfirmContent(room.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.common_cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<RoomsBloc>().add(DeleteRoomEvent(room.id));
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
        title: Text(l10n.home_roomsButton),
      ),
      body: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (context, state) {
          if (state is RoomsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomsLoaded) {
            if (state.rooms.isEmpty) {
              return Center(child: Text(l10n.rooms_emptyList));
            }

            return ListView.builder(
              itemCount: state.rooms.length,
              itemBuilder: (context, index) {
                final room = state.rooms[index];

                return ListTile(
                  title: Text(room.name),
                  subtitle: room.description != null
                      ? Text(room.description!)
                      : null,
                  leading: const Icon(Icons.meeting_room),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _confirmDelete(context, room),
                  ),
                  onTap: () => _showRoomForm(context, room),
                );
              },
            );
          } else if (state is RoomsError) {
            return Center(
                child: Text(l10n.common_error(state.failure.toLocalizedString(l10n))));
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showRoomForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
