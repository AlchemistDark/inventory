import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerDialog extends StatefulWidget {
  final void Function(String) onBarcodeSubmitted;

  const BarcodeScannerDialog({required this.onBarcodeSubmitted, super.key});

  @override
  State<BarcodeScannerDialog> createState() => _BarcodeScannerDialogState();
}

class _BarcodeScannerDialogState extends State<BarcodeScannerDialog> {
  final _barcodeController = TextEditingController();
  final _scannerController = MobileScannerController();
  bool _isScanHandled = false;

  @override
  void dispose() {
    _barcodeController.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  void _submitBarcode(String value) {
    final barcode = value.trim();
    if (barcode.isEmpty) {
      return;
    }
    widget.onBarcodeSubmitted(barcode);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.home.barcodeDialogTitle),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.home.barcodeDialogHint,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
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
                  final message =
                      error.errorCode == MobileScannerErrorCode.permissionDenied
                      ? AppStrings.home.scannerPermissionDeniedMessage
                      : AppStrings.home.scannerUnavailableMessage;
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
            TextField(
              controller: _barcodeController,
              decoration: InputDecoration(
                labelText: AppStrings.home.barcodeFieldLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.qr_code),
              ),
              autofocus: true,
              onSubmitted: _submitBarcode,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.home.cancelButton),
        ),
        ElevatedButton(
          onPressed: () {
            _submitBarcode(_barcodeController.text);
          },
          child: Text(AppStrings.home.saveButton),
        ),
      ],
    );
  }
}
