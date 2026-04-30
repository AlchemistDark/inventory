import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A single row in the room list.
class RoomListTile extends StatelessWidget {
  /// Creates a [RoomListTile].
  const RoomListTile({
    required this.room,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  /// The room entity for this tile.
  final RoomEntity room;

  /// Callback for the delete action.
  final VoidCallback onDelete;

  /// Callback for the tap action.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(room.name),
      subtitle: room.description != null ? Text(room.description!) : null,
      leading: const Icon(Icons.meeting_room),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
