import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying detailed information about a specific inventory item.
///
/// Retrieves the item from the current [InventoryBloc] state based on [inventoryId].
/// Provides an edit button to navigate to [CreateInventoryPage] in edit mode.
class InventoryDetailsPage extends StatelessWidget {
  /// Creates an [InventoryDetailsPage].
  const InventoryDetailsPage({required this.inventoryId, super.key});

  static void _confirmDelete(BuildContext context, InventoryEntity inventory) {
    final l10n = AppLocalizations.of(context)!;
    final inventoryBloc = context.read<InventoryBloc>();
    final entityLabel = l10n.invForm_nameFieldLabel;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.common_deleteConfirmTitle(entityLabel)),
        content: Text(l10n.common_deleteConfirmContent(inventory.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.common_cancel),
          ),
          TextButton(
            onPressed: () {
              inventoryBloc.add(DeleteInventoryEvent(inventory.id));
              Navigator.pop(dialogContext); // Close dialog
              Navigator.pop(context); // Go back to inventory list
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

  /// The unique identifier of the inventory item to display.
  final int inventoryId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home_itemDetailsTitle),
        actions: [
          BlocBuilder<InventoryBloc, InventoryState>(
            builder: (context, state) {
              if (state is InventoriesLoaded) {
                final currentInventory = state.inventories.getById(inventoryId);

                if (currentInventory != null) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            CreateInventoryPage.route(editTarget: currentInventory),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () =>
                            _confirmDelete(context, currentInventory),
                      ),
                    ],
                  );
                }
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EmployeesBloc, EmployeesState>(
            listener: (context, state) {
              if (state is EmployeesLoaded) {
                context.read<InventoryBloc>().add(const LoadInventoriesEvent());
              }
            },
          ),
          BlocListener<RoomsBloc, RoomsState>(
            listener: (context, state) {
              if (state is RoomsLoaded) {
                context.read<InventoryBloc>().add(const LoadInventoriesEvent());
              }
            },
          ),
          BlocListener<CategoriesBloc, CategoriesState>(
            listener: (context, state) {
              if (state is CategoriesLoaded) {
                context.read<InventoryBloc>().add(const LoadInventoriesEvent());
              }
            },
          ),
        ],
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            if (state is InventoriesLoaded) {
              final currentInventory = state.inventories.getById(inventoryId);

              if (currentInventory == null) {
                return Center(child: Text(l10n.invList_emptyStateMessage));
              }

              final employeeName = state.employees.getNameById(
                currentInventory.employeeId,
                fallback: l10n.invList_notSpecifiedMale,
              );
              final roomName = state.rooms.getNameById(
                currentInventory.roomId,
                fallback: l10n.invList_notSpecified,
              );
              final categoryNames = currentInventory.categoryIds
                  .map((id) => state.categories.getNameById(id,
                      fallback: l10n.invList_notSpecifiedFemale))
                  .join(', ');

              return InventoryDetailsContent(
                inventory: currentInventory,
                employeeName: employeeName,
                roomName: roomName,
                categoryName: categoryNames.isEmpty
                    ? l10n.invList_notSpecifiedFemale
                    : categoryNames,
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
