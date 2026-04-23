import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class InventoryListPage extends StatelessWidget {
  const InventoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.inventoryList.appBarTitle)),
      body: Column(
        children: [
          const InventoryListHeader(),
          Expanded(
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (context, state) {
                if (state is InventoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InventoriesLoaded) {
                  return InventoryListView(state: state);
                } else if (state is InventoryError) {
                  return Center(
                    child: Text(
                      '${AppStrings.inventoryList.errorMessagePrefix}${state.message}',
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
        backgroundColor: Theme.of(context).cardTheme.color ?? Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const CreateInventoryPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
