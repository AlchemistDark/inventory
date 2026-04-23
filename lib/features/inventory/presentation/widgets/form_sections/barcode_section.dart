import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class BarcodeSection extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onBarcodeSaved;

  const BarcodeSection({
    super.key,
    required this.controller,
    required this.onBarcodeSaved,
  });

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
