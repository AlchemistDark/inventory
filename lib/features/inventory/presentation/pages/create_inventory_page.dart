import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class CreateInventoryPage extends StatelessWidget {
  const CreateInventoryPage({super.key, this.editTarget});

  final InventoryEntity? editTarget;

  @override
  Widget build(BuildContext context) {
    context.read<InventoryFormBloc>().add(const LoadFormMetadataEvent());
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
