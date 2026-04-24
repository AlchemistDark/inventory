import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import '../widgets/details/inventory_details_content.dart';

class InventoryDetailsPage extends StatelessWidget {
  final InventoryEntity inventory;

  const InventoryDetailsPage({required this.inventory, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home_itemDetailsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (context) =>
                      CreateInventoryPage(editTarget: inventory),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          if (state is InventoriesLoaded) {
            final employeeMap = {for (final e in state.employees) e.id: e.name};
            final roomMap = {for (final r in state.rooms) r.id: r.name};
            final categoryMap = {for (final c in state.categories) c.id: c.name};

            final employeeName = employeeMap[inventory.employeeId] ??
                l10n.invList_notSpecifiedMale;
            final roomName =
                roomMap[inventory.roomId] ?? l10n.invList_notSpecified;
            final categoryName = categoryMap[inventory.categoryId] ??
                l10n.invList_notSpecifiedFemale;

            return InventoryDetailsContent(
              inventory: inventory,
              employeeName: employeeName,
              roomName: roomName,
              categoryName: categoryName,
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
