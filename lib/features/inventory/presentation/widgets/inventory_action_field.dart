import 'package:inventory_p_shalaev/core/core.dart';

/// A custom widget for displaying a labeled value that triggers an action on tap.
///
/// Designed for the inventory form to show information like selected dates
/// or other non-editable fields that open a picker or dialog.
class InventoryActionField extends StatelessWidget {
  /// Creates an [InventoryActionField].
  const InventoryActionField({
    required this.label,
    required this.valueText,
    required this.icon,
    required this.onTap,
    super.key,
  });

  /// The label text displayed above the field.
  final String label;

  /// The current value text displayed inside the field.
  final String valueText;

  /// The icon displayed on the right side of the field.
  final IconData icon;

  /// The callback triggered when the field is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: AppTheme.fieldDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(valueText), Icon(icon)],
            ),
          ),
        ),
      ],
    );
  }
}
