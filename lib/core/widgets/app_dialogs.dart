import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Utility class for showing standardized application dialogs.
class AppDialogs {
  /// Shows a confirmation dialog for deleting an entity.
  ///
  /// Returns [true] if the user confirmed the deletion.
  static Future<bool?> showDeleteConfirmation({
    required BuildContext context,
    required String entityName,
    String? entityTypeLabel,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final title = entityTypeLabel != null 
        ? l10n.common_deleteConfirmTitle(entityTypeLabel)
        : l10n.common_delete;

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(l10n.common_deleteConfirmContent(entityName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.common_delete),
          ),
        ],
      ),
    );
  }
}
