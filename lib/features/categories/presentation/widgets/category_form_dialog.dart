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
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  TextEditingController? _descController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name);
    _descController = TextEditingController(text: widget.category?.description);
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave(
        _nameController!.text.trim(),
        _descController?.text.trim(),
      );
      Navigator.pop(context);
    }
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
    final nameController = _nameController;
    final descController = _descController;

    if (nameController == null || descController == null) {
      return const SizedBox.shrink();
    }

    return AlertDialog(
      title: Text(widget.category == null
          ? l10n.categories_newTitle
          : l10n.categories_editTitle),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: l10n.categories_nameLabel,
                hintText: l10n.employees_nameLabel,
              ),
              autofocus: true,
              maxLength: 50,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.length < 3) {
                  return l10n.employees_minLength3;
                }

                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descController,
              decoration:
                  InputDecoration(labelText: l10n.categories_descriptionLabel),
              maxLines: 3,
              minLines: 1,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.home_cancelButton),
        ),
        TextButton(
          onPressed: _onSave,
          child: Text(l10n.home_saveButton),
        ),
      ],
    );
  }
}
