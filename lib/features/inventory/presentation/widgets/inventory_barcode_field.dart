import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A custom widget for displaying and interacting with an inventory item's barcode.
///
/// Shows the current barcode value and provides a scan button that triggers
/// [onScanPressed].
class InventoryBarcodeField extends StatelessWidget {
  /// Creates an [InventoryBarcodeField].
  const InventoryBarcodeField({
    required this.controller,
    required this.onScanPressed,
    super.key,
  });

  /// Controller whose text holds the current barcode value.
  final TextEditingController controller;

  /// Callback triggered when the scan button is pressed.
  final VoidCallback onScanPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.invForm_barcodeLabel,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: AppTheme.fieldDecoration,
                child: Text(
                  controller.text.isEmpty
                      ? l10n.invForm_noBarcode
                      : controller.text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onScanPressed,
              icon: const Icon(Icons.qr_code_2),
              tooltip: l10n.invForm_scanOrInputTooltip,
            ),
          ],
        ),
      ],
    );
  }
}
