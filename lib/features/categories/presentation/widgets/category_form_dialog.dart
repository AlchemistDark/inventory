import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/categories/domain/entities/category_entity.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A dialog for creating or editing a category
class CategoryFormDialog extends StatefulWidget {
  /// Creates a [CategoryFormDialog]
  const CategoryFormDialog({
    required this.onSave,
    this.category,
    super.key,
  });

  /// The category to edit, or null if creating a new one
  final CategoryEntity? category;

  /// Callback called when the user saves the form
  final void Function(String name, String? description) onSave;

  @override
  State<CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  TextEditingController? _nameController;
  TextEditingController? _descController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name);
    _descController = TextEditingController(text: widget.category?.description);
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _descController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(widget.category == null
          ? l10n.categories_newTitle
          : l10n.categories_editTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: l10n.categories_nameLabel),
            autofocus: true,
          ),
          TextField(
            controller: _descController,
            decoration:
                InputDecoration(labelText: l10n.categories_descriptionLabel),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.home_cancelButton),
        ),
        TextButton(
          onPressed: () {
            if (_nameController?.text.isNotEmpty ?? false) {
              widget.onSave(_nameController!.text, _descController?.text);
              Navigator.pop(context);
            }
          },
          child: Text(l10n.home_saveButton),
        ),
      ],
    );
  }
}
