import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Page for creating a new inventory item or editing an existing one.
///
/// Uses [InventoryFormBloc] for handling form logic and [editTarget] to
/// determine if the page is in creation or edit mode.
class CreateInventoryPage extends StatelessWidget {
  /// Creates a [CreateInventoryPage].
  ///
  /// If [editTarget] is provided, the page will be pre-populated for editing.
  const CreateInventoryPage({super.key, this.editTarget});

  /// The inventory entity to be edited, or null if creating a new item.
  final InventoryEntity? editTarget;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Load metadata needed for the form dropdowns immediately.
    context.read<InventoryFormBloc>().add(LoadFormMetadataEvent(l10n));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editTarget == null
              ? l10n.invForm_appBarCreateTitle
              : l10n.invForm_appBarEditTitle,
        ),
      ),
      body: BlocListener<InventoryFormBloc, InventoryFormState>(
        listener: (context, state) {
          if (state is InventoryFormSuccess) {
            // Navigate back and refresh the inventory list on success.
            Navigator.pop(context);
            context.read<InventoryBloc>().add(const LoadInventoriesEvent());
          } else if (state is InventoryFormError) {
            // Show error message using the theme-defined snackbar style.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.toLocalizedString(l10n)),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: CreateInventoryForm(editTarget: editTarget),
      ),
    );
  }
}
