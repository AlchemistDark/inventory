import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class InventoryBarcodeInputDialog extends StatefulWidget {
  final String initialBarcode;
  final ValueChanged<String> onBarcodeSaved;

  const InventoryBarcodeInputDialog({
    super.key,
    required this.initialBarcode,
    required this.onBarcodeSaved,
  });

  @override
  State<InventoryBarcodeInputDialog> createState() =>
      _InventoryBarcodeInputDialogState();
}

class _InventoryBarcodeInputDialogState
    extends State<InventoryBarcodeInputDialog> {
  late final TextEditingController _barcodeController;
  final MobileScannerController _scannerController = MobileScannerController();
  bool _isScanHandled = false;

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
    return AlertDialog(
      title: Text(AppStrings.createInventory.barcodeDialogTitle),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _barcodeController,
              decoration: InputDecoration(
                labelText: AppStrings.createInventory.barcodeFieldInDialog,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(AppStrings.createInventory.cameraScanText),
            const SizedBox(height: 12),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
              clipBehavior: Clip.antiAlias,
              child: MobileScanner(
                controller: _scannerController,
                onDetect: (capture) {
                  if (_isScanHandled) return;
                  if (capture.barcodes.isEmpty) return;

                  final barcode = capture.barcodes.first.rawValue;
                  if (barcode == null || barcode.trim().isEmpty) return;

                  _isScanHandled = true;
                  // Scanning overrides the manual input
                  _barcodeController.text = barcode;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(AppStrings.createInventory.scannedSuccessMessage),
                        duration: const Duration(seconds: 1)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            _isScanHandled = false; // allow scan again
            _scannerController.start();
          },
          icon: const Icon(Icons.refresh),
          label: Text(AppStrings.createInventory.resetScannerButton),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.createInventory.cancelButton),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onBarcodeSaved(_barcodeController.text);
            Navigator.pop(context);
          },
          child: Text(AppStrings.createInventory.saveButton),
        ),
      ],
    );
  }
}
