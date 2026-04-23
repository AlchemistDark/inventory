import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class CreateInventoryPage extends StatelessWidget {
  final InventoryEntity? editTarget;

  const CreateInventoryPage({super.key, this.editTarget});

  @override
  Widget build(BuildContext context) {
    context.read<InventoryFormBloc>().add(const LoadFormMetadataEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editTarget == null
              ? AppStrings.createInventory.appBarCreateTitle
              : AppStrings.createInventory.appBarEditTitle,
        ),
      ),
      body: BlocListener<InventoryFormBloc, InventoryFormState>(
        listener: (context, state) {
          if (state is InventoryFormSuccess) {
            Navigator.pop(context);
            context.read<InventoryBloc>().add(const LoadInventoriesEvent());
          } else if (state is InventoryFormError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: CreateInventoryForm(editTarget: editTarget),
      ),
    );
  }
}
