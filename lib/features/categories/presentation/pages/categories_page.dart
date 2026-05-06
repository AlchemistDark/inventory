import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying the list of categories with CRUD operations
class CategoriesPage extends StatelessWidget {
  /// Creates a [CategoriesPage]
  const CategoriesPage({super.key});

  static void _showCategoryForm(BuildContext context, [CategoryEntity? category]) {
    Navigator.push<void>(
      context,
      CategoryFormPage.route(category: category),
    );
  }

  static Future<void> _confirmDelete(BuildContext context, CategoryEntity category) async {
    final l10n = AppLocalizations.of(context)!;
    final categoriesBloc = context.read<CategoriesBloc>();

    final confirmed = await AppDialogs.showDeleteConfirmation(
      context: context,
      entityName: category.name,
      entityTypeLabel: l10n.categories_nameLabel,
    );

    if (confirmed == true) {
      categoriesBloc.add(DeleteCategoryEvent(category.id));
    }
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
