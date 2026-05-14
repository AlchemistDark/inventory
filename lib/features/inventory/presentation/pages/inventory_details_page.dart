import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying detailed information about a specific inventory item.
///
/// Retrieves the item from the current [InventoryBloc] state based on [inventoryId].
/// Provides an edit button to navigate to [CreateInventoryPage] in edit mode.
class InventoryDetailsPage extends StatelessWidget {
  /// Creates an [InventoryDetailsPage].
  const InventoryDetailsPage({required this.inventoryId, super.key});

  static Future<void> _confirmDelete(BuildContext context, InventoryEntity inventory) async {
    final l10n = AppLocalizations.of(context)!;
    final inventoryBloc = context.read<InventoryBloc>();

    final confirmed = await AppDialogs.showDeleteConfirmation(
      context: context,
      entityName: inventory.name,
      entityTypeLabel: l10n.common_item,
    );

    if (confirmed == true) {
      inventoryBloc.add(DeleteInventoryEvent(inventory.id));
      if (context.mounted) {
        Navigator.pop(context); // Go back to inventory list
      }
    }
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

              // Get actual metadata from their respective blocs to ensure sync
              final empState = context.watch<EmployeesBloc>().state;
              final roomState = context.watch<RoomsBloc>().state;
              final catState = context.watch<CategoriesBloc>().state;

              final employees = empState is EmployeesLoaded ? empState.allEmployees : state.employees;
              final rooms = roomState is RoomsLoaded ? roomState.rooms : state.rooms;
              final categories = catState is CategoriesLoaded ? catState.categories : state.categories;

              final employeeName = employees.getNameById(
                currentInventory.employeeId,
                fallback: l10n.invList_notSpecifiedMale,
              );
              final roomName = rooms.getNameById(
                currentInventory.roomId,
                fallback: l10n.invList_notSpecified,
              );
              final categoryNames = categories
                  .where((c) => currentInventory.categoryIds.contains(c.id))
                  .map((c) => c.name)
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
