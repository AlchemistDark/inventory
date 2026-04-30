import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/error/app_failure.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying a list of all inventory items.
///
/// Provides filtering capabilities via [InventoryListHeader] and uses
/// [InventoryListView] to render the actual list based on [InventoryBloc] state.
class InventoryListPage extends StatelessWidget {
  /// Creates an [InventoryListPage].
  const InventoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.invList_appBarTitle)),
      body: Column(
        children: [
          const InventoryListHeader(),
          Expanded(
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (context, state) {
                if (state is InventoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InventoriesLoaded) {
                  return InventoryListView(
                    items: state.filteredInventories,
                    employees: state.employees,
                    rooms: state.rooms,
                  );
                } else if (state is InventoryError) {
                  return Center(
                    child: Text(
                      '${l10n.invList_errorMessagePrefix}${state.failure.toLocalizedString(l10n)}',
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardTheme.color ??
            Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push<void>(
            context,
            CreateInventoryPage.route(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
