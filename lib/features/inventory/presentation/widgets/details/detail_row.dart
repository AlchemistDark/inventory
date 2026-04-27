import 'package:flutter/material.dart';

/// A reusable row for displaying a labeled value with an optional icon.
///
/// Designed for the details page, it shows a small label above a larger value.
class DetailRow extends StatelessWidget {
  /// Creates a [DetailRow].
  const DetailRow({
    required this.label,
    required this.value,
    this.icon,
    super.key,
  });

  /// The label for the data point.
  final String label;

  /// The value of the data point.
  final String value;

  /// An optional icon to display to the left of the label/value.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: Colors.blue),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
