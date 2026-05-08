import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page for creating or editing a category.
class CategoryFormPage extends StatefulWidget {
  /// Creates a [CategoryFormPage].
  const CategoryFormPage({this.category, super.key});

  /// Static method to get the route for this page.
  static Route<void> route({CategoryEntity? category}) {
    return MaterialPageRoute<void>(
      builder: (_) => CategoryFormPage(category: category),
    );
  }

  /// The category to edit, or null if creating a new one.
  final CategoryEntity? category;

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.category?.name ?? '';
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final category = CategoryEntity(
        id: widget.category?.id ?? 0,
        name: _nameController.text.trim(),
        createdAt: widget.category?.createdAt ?? DateTime.now(),
      );

      if (widget.category == null) {
        context.read<CategoriesBloc>().add(CreateCategoryEvent(category));
      } else {
        context.read<CategoriesBloc>().add(UpdateCategoryEvent(category));
      }

      Navigator.pop(context);

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Text(
            widget.category == null
                ? l10n.categories_created
                : l10n.categories_updated,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.category != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.categories_editTitle : l10n.categories_newTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.categories_nameLabel,
                ),
                autofocus: !isEditing,
                maxLength: 50,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.length < 3) {
                    return l10n.invForm_minLength3Error;
                  }

                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSave,
                  child: Text(
                    isEditing ? l10n.common_save : l10n.common_create,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
