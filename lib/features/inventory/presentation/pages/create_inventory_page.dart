import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Page for creating a new inventory item or editing an existing one.
class CreateInventoryPage extends StatelessWidget {
  /// Creates a [CreateInventoryPage].
  const CreateInventoryPage({super.key, this.editTarget});

  /// Helper method to create a route for this page with a scoped [InventoryFormBloc].
  static Route<void> route({InventoryEntity? editTarget, String? initialBarcode}) {
    return MaterialPageRoute<void>(
      settings: RouteSettings(
        arguments: initialBarcode != null ? {'initialBarcode': initialBarcode} : null,
      ),
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;

        return BlocProvider(
          create: (context) => ServiceLocator.getIt<InventoryFormBloc>()
            ..add(LoadFormMetadataEvent(l10n)),
          child: CreateInventoryPage(editTarget: editTarget),
        );
      },
    );
  }

  /// The inventory entity to be edited, or null if creating a new item.
  final InventoryEntity? editTarget;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                content: Text(
                  editTarget == null
                      ? l10n.invList_itemAddedMessage
                      : l10n.invList_itemUpdatedMessage,
                ),
              ),
            );
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
