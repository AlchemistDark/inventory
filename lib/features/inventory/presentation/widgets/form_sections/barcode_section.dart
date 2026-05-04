import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A section of the inventory form dedicated to barcode management.
///
/// It displays the current barcode value and provides an entry point to the
/// barcode input/scan dialog.
class BarcodeSection extends StatelessWidget {
  /// Creates a [BarcodeSection].
  const BarcodeSection({
    required this.controller,
    required this.onBarcodeSaved,
    super.key,
  });

  /// Controller managing the barcode text value.
  final TextEditingController controller;

  /// Callback triggered when a barcode is scanned or manually saved in the dialog.
  final ValueChanged<String> onBarcodeSaved;

  @override
  Widget build(BuildContext context) {
    return InventoryBarcodeField(
      controller: controller,
      onScanPressed: () {
        // Show the barcode input/scan dialog on press.
        showDialog(
          context: context,
          builder: (context) => InventoryBarcodeInputDialog(
            initialBarcode: controller.text,
            onBarcodeSaved: onBarcodeSaved,
          ),
        );
      },
    );
  }
}
