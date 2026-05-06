import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A dialog that allows users to input a barcode manually or scan it using the camera.
///
/// Uses [MobileScanner] for camera-based scanning. When a barcode is detected
/// or manually entered, it can be saved back to the form via [onBarcodeSaved].
class InventoryBarcodeInputDialog extends StatefulWidget {
  /// Creates an [InventoryBarcodeInputDialog].
  const InventoryBarcodeInputDialog({
    required this.initialBarcode,
    required this.onBarcodeSaved,
    super.key,
  });

  /// The barcode value to show when the dialog opens.
  final String initialBarcode;

  /// Callback triggered when the 'Save' button is pressed.
  final ValueChanged<String> onBarcodeSaved;

  @override
  State<InventoryBarcodeInputDialog> createState() =>
      _InventoryBarcodeInputDialogState();
}

class _InventoryBarcodeInputDialogState
    extends State<InventoryBarcodeInputDialog> {
  final MobileScannerController _scannerController = MobileScannerController();
  // ignore: avoid-late-keyword
  late TextEditingController _barcodeController;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _barcodeController = TextEditingController(text: widget.initialBarcode);
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.invForm_barcodeDialogTitle),
      content: SizedBox(
        width: 360,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Manual input field.
              TextField(
                controller: _barcodeController,
                decoration: InputDecoration(
                  labelText: l10n.invForm_barcodeFieldInDialog,
                  prefixIcon: const Icon(Icons.qr_code),
                ),
              ),
              const SizedBox(height: 16),
              // Main action buttons directly under the field.
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isScanning = !_isScanning;
                        });
                      },
                      icon: Icon(_isScanning ? Icons.stop : Icons.camera_alt),
                      label: Text(l10n.home_scanButton),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onBarcodeSaved(_barcodeController.text);
                        Navigator.pop(context);
                      },
                      child: Text(l10n.home_saveButton),
                    ),
                  ),
                ],
              ),
              // Scanner preview shown only when scanning is active.
              if (_isScanning) ...[
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppTheme.scanBarrierColor,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: MobileScanner(
                    controller: _scannerController,
                    onDetect: (capture) {
                      if (capture.barcodes.isEmpty) {
                        return;
                      }

                      final barcode = capture.barcodes.first.rawValue;
                      if (barcode != null && barcode.trim().isNotEmpty) {
                        setState(() {
                          _barcodeController.text = barcode;
                          _isScanning = false; // Stop scanning after detection.
                        });
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.invForm_scannedSuccessMessage),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.home_cancelButton),
        ),
      ],
    );
  }
}
