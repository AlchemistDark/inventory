import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.notFoundDialogTitle),
      content: Text(l10n.notFoundDialogContent(query)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancelButton),
        ),
        ElevatedButton(
          onPressed: onCreate,
          child: Text(l10n.createButton),
        ),
      ],
    );
  }
}
