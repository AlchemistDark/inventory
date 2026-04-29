import 'package:inventory_p_shalaev/core/core.dart';

/// A vertical layout widget for displaying a label and its corresponding value.
///
/// Similar to [DetailRow] but without icon support and with an optional title style
/// for the value text.
class DetailSection extends StatelessWidget {
  /// Creates a [DetailSection].
  const DetailSection({
    required this.label,
    required this.value,
    this.isTitle = false,
    super.key,
  });

  /// The label describing the value.
  final String label;

  /// The value string to display.
  final String value;

  /// Whether the value should be displayed with a large title font style.
  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.greyDarkColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: isTitle ? 20 : 16,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
