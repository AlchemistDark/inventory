import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// A dialog providing barcode scanning via camera and manual barcode input.
class BarcodeScannerDialog extends StatefulWidget {
  /// Creates a [BarcodeScannerDialog].
  ///
  /// [onBarcodeSubmitted] is called when a barcode is successfully scanned or entered.
  const BarcodeScannerDialog({required this.onBarcodeSubmitted, super.key});

  /// Callback function triggered on barcode submission.
  final ValueChanged<String> onBarcodeSubmitted;

  @override
  State<BarcodeScannerDialog> createState() => _BarcodeScannerDialogState();
}

class _BarcodeScannerDialogState extends State<BarcodeScannerDialog> {
  final _barcodeController = TextEditingController();
  final _scannerController = MobileScannerController();
  bool _isScanHandled = false;

  void _submitBarcode(String value) {
    final barcode = value.trim();
    if (barcode.isEmpty) {
      return;
    }
    widget.onBarcodeSubmitted(barcode);
    Navigator.pop(context);
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
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return AlertDialog(
      title: Text(l10n.home_barcodeDialogTitle),
      scrollable: true,
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isKeyboardVisible) ...[
              Text(
                l10n.home_barcodeDialogHint,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
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
                    if (_isScanHandled) {
                      return;
                    }
                    if (capture.barcodes.isEmpty) {
                      return;
                    }
                    final barcode = capture.barcodes.first.rawValue;
                    if (barcode == null || barcode.trim().isEmpty) {
                      return;
                    }

                    _isScanHandled = true;
                    _submitBarcode(barcode);
                  },
                  errorBuilder: (context, error, child) {
                    final message = error.errorCode ==
                            MobileScannerErrorCode.permissionDenied
                        ? l10n.home_scannerPermissionDeniedMessage
                        : l10n.home_scannerUnavailableMessage;

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
            TextField(
              controller: _barcodeController,
              decoration: InputDecoration(
                labelText: l10n.home_barcodeFieldLabel,
                prefixIcon: const Icon(Icons.qr_code),
              ),
              autofocus: false,
              onSubmitted: _submitBarcode,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.home_cancelButton),
        ),
        ElevatedButton(
          onPressed: () {
            _submitBarcode(_barcodeController.text);
          },
          child: Text(l10n.home_saveButton),
        ),
      ],
    );
  }
}
