import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class BarcodeSection extends StatelessWidget {
  const BarcodeSection({
    required this.controller,
    required this.onBarcodeSaved,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String) onBarcodeSaved;

  @override
  Widget build(BuildContext context) {
    return InventoryBarcodeField(
      controller: controller,
      onScanPressed: () {
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
