import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import '../widgets/details/inventory_details_content.dart';

class InventoryDetailsPage extends StatelessWidget {
  const InventoryDetailsPage({required this.inventory, super.key});

  final InventoryEntity inventory;

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
            final employeeName = state.employees
                    .where((e) => e.id == inventory.employeeId)
                    .firstOrNull
                    ?.name ??
                l10n.invList_notSpecifiedMale;
            final roomName = state.rooms
                    .where((r) => r.id == inventory.roomId)
                    .firstOrNull
                    ?.name ??
                l10n.invList_notSpecified;
            final categoryName = state.categories
                    .where((c) => c.id == inventory.categoryId)
                    .firstOrNull
                    ?.name ??
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
