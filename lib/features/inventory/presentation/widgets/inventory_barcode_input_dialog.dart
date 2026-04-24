import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

class InventoryBarcodeInputDialog extends StatefulWidget {
  const InventoryBarcodeInputDialog({
    required this.initialBarcode,
    required this.onBarcodeSaved,
    super.key,
  });

  final String initialBarcode;
  final ValueChanged<String> onBarcodeSaved;

  @override
  State<InventoryBarcodeInputDialog> createState() =>
      _InventoryBarcodeInputDialogState();
}

class _InventoryBarcodeInputDialogState
    extends State<InventoryBarcodeInputDialog> {
  // ignore: avoid-late-keyword
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
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.invForm_barcodeDialogTitle),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _barcodeController,
              decoration: InputDecoration(
                labelText: l10n.invForm_barcodeFieldInDialog,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(l10n.invForm_cameraScanText),
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
                  if (_isScanHandled || capture.barcodes.isEmpty) {
                    return;
                  }

                  final barcode = capture.barcodes.first.rawValue;
                  if (barcode == null || barcode.trim().isEmpty) {
                    return;
                  }

                  _isScanHandled = true;
                  // Scanning overrides the manual input
                  _barcodeController.text = barcode;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        l10n.invForm_scannedSuccessMessage,
                      ),
                      duration: const Duration(seconds: 1),
                    ),
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
          label: Text(l10n.invForm_resetScannerButton),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.invForm_cancelButton),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onBarcodeSaved(_barcodeController.text);
            Navigator.pop(context);
          },
          child: Text(l10n.invForm_saveButton),
        ),
      ],
    );
  }
}
