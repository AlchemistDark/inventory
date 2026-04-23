import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class InventoryNotFoundDialog extends StatelessWidget {
  const InventoryNotFoundDialog({
    required this.query,
    required this.onCreate,
    super.key,
  });

  final String query;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.home.notFoundDialogTitle),
      content: Text(
        AppStrings.home.notFoundDialogContent.replaceAll('%s', query),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.home.cancelButton),
        ),
        ElevatedButton(
          onPressed: onCreate,
          child: Text(AppStrings.home.createButton),
        ),
      ],
    );
  }
}
