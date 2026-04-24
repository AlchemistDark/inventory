import 'package:inventory_p_shalaev/core/core.dart';

class InventoryActionField extends StatelessWidget {
  const InventoryActionField({
    required this.label,
    required this.valueText,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String label;
  final String valueText;
  final IconData icon;
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
