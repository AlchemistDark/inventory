import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A widget that displays a list of rooms.
class RoomList extends StatelessWidget {
  /// Creates a [RoomList].
  const RoomList({
    required this.rooms,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  /// The list of rooms to display.
  final List<RoomEntity> rooms;

  /// Callback triggered when a room is deleted.
  final ValueChanged<RoomEntity> onDelete;

  /// Callback triggered when a room is tapped (for editing).
  final ValueChanged<RoomEntity> onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];

        return RoomListTile(
          room: room,
          onDelete: () => onDelete(room),
          onTap: () => onTap(room),
        );
      },
    );
  }
}
