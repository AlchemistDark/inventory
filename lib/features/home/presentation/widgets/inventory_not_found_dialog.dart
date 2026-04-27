import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Dialog shown when a searched inventory item is not found.
///
/// Offers an option to create a new inventory item with the searched query.
class InventoryNotFoundDialog extends StatelessWidget {
  /// Creates an [InventoryNotFoundDialog].
  const InventoryNotFoundDialog({
    required this.query,
    required this.onCreate,
    super.key,
  });

  /// The search query that returned no results.
  final String query;

  /// Callback triggered when the "Create" button is pressed.
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.home_notFoundDialogTitle),
      content: Text(l10n.home_notFoundDialogContent(query)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.home_cancelButton),
        ),
        ElevatedButton(
          onPressed: onCreate,
          child: Text(l10n.home_createButton),
        ),
      ],
    );
  }
}
