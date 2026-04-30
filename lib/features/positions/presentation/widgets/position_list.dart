import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A widget that displays a list of positions.
class PositionList extends StatelessWidget {
  /// Creates a [PositionList].
  const PositionList({
    required this.positions,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  /// The list of positions to display.
  final List<PositionEntity> positions;

  /// Callback triggered when a position is deleted.
  final ValueChanged<PositionEntity> onDelete;

  /// Callback triggered when a position is tapped (for editing).
  final ValueChanged<PositionEntity> onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: positions.length,
      itemBuilder: (context, index) {
        final position = positions[index];

        return PositionListTile(
          position: position,
          onDelete: () => onDelete(position),
          onTap: () => onTap(position),
        );
      },
    );
  }
}
