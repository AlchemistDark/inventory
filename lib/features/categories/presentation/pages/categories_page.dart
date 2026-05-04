import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying the list of categories with CRUD operations
class CategoriesPage extends StatelessWidget {
  /// Creates a [CategoriesPage]
  const CategoriesPage({super.key});

  void _showCategoryForm(BuildContext context, [CategoryEntity? category]) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => CategoryFormDialog(
        category: category,
        onSave: (String name, String? description) {
          final newCategory = CategoryEntity(
            id: category?.id ?? 0,
            name: name,
            description: description,
            createdAt: category?.createdAt ?? DateTime.now(),
          );
          if (category == null) {
            context.read<CategoriesBloc>().add(
                  CreateCategoryEvent(newCategory),
                );
          } else {
            context.read<CategoriesBloc>().add(
                  UpdateCategoryEvent(newCategory),
                );
          }
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                category == null
                    ? l10n.categories_created
                    : l10n.categories_updated,
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, CategoryEntity category) {
    final l10n = AppLocalizations.of(context)!;
    final categoriesBloc = context.read<CategoriesBloc>();

    final nameLabel = l10n.categories_nameLabel;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.common_deleteConfirmTitle(nameLabel)),
        content: Text(l10n.common_deleteConfirmContent(category.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.common_cancel),
          ),
          TextButton(
            onPressed: () {
              categoriesBloc.add(DeleteCategoryEvent(category.id));
              Navigator.pop(dialogContext);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.common_delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.home_categoriesButton)),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesLoaded) {
            if (state.categories.isEmpty) {
              return Center(child: Text(l10n.categories_emptyList));
            }

            return CategoryList(
              categories: state.categories,
              onDelete: (CategoryEntity category) => _confirmDelete(context, category),
              onTap: (CategoryEntity category) => _showCategoryForm(context, category),
            );
          } else if (state is CategoriesError) {
            return Center(
              child: Text(
                l10n.common_error(state.failure.toLocalizedString(l10n)),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
