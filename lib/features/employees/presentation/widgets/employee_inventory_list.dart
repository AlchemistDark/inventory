import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Sliver list displaying inventory assigned to a specific employee.
class EmployeeInventoryList extends StatelessWidget {
  /// Creates an [EmployeeInventoryList].
  const EmployeeInventoryList({
    required this.isDetailsLoading,
    required this.selectedEmployeeInventory,
    super.key,
  });

  final bool isDetailsLoading;

  final List<InventoryEntity> selectedEmployeeInventory;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (isDetailsLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (selectedEmployeeInventory.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        sliver: SliverToBoxAdapter(
          child: Center(
            child: Text(
              l10n.employees_noInventory,
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = selectedEmployeeInventory[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                      '${l10n.common_inventoryNumberPrefix}${item.inventoryNumber}'),
                  trailing: Text('x${item.quantity}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => InventoryDetailsPage(
                          inventoryId: item.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          childCount: selectedEmployeeInventory.length,
        ),
      ),
    );
  }
}
