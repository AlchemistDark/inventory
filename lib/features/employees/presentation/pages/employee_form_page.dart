import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page for creating or editing an employee record.
///
/// This widget is stateless and uses [TextFormField] with `initialValue`
/// to avoid manual [TextEditingController] management.
class EmployeeFormPage extends StatelessWidget {
  /// Creates an [EmployeeFormPage].
  const EmployeeFormPage({this.employee, super.key});

 /// Helper method to create a route for this page with a scoped [EmployeeFormBloc].
  static Route<void> route({EmployeeEntity? employee}) {
    return MaterialPageRoute<void>(
      builder: (context) => BlocProvider(
        create: (_) => ServiceLocator.getIt<EmployeeFormBloc>()
          ..add(InitializeEmployeeForm(employee: employee)),
        child: EmployeeFormPage(employee: employee),
      ),
    );
  }

  /// The employee to edit, or null if creating a new one.
  final EmployeeEntity? employee;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<EmployeeFormBloc, EmployeeFormState>(
      listener: (context, state) {
        if (state is EmployeeFormSuccess) {
          context.read<EmployeesBloc>().add(LoadEmployeesEvent());
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(employee == null
                  ? l10n.employees_created
                  : l10n.employees_updated),
            ),
          );
        } else if (state is EmployeeFormValidationFailed) {
          final message = switch (state.error) {
            EmployeeFormValidationError.positionRequired =>
              l10n.employees_selectPosition,
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        } else if (state is EmployeeFormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure.toLocalizedString(l10n))),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(employee == null
                ? l10n.employees_createTitle
                : l10n.employees_editTitle),
          ),
          body: state is EmployeeFormLoading
              ? const Center(child: CircularProgressIndicator())
              : state is EmployeeFormMetadataLoaded
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            initialValue: employee?.name,
                            decoration: InputDecoration(
                              labelText: l10n.employees_nameLabel,
                              errorText: switch (state.nameError) {
                                EmployeeNameValidationError.tooShort =>
                                  l10n.employees_minLength3,
                                EmployeeNameValidationError.tooLong =>
                                  l10n.employees_maxLength50,
                                null => null,
                              },
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                            onChanged: (value) => context
                                .read<EmployeeFormBloc>()
                                .add(NameChanged(value)),
                          ),
                          const SizedBox(height: 20),
                          InventorySelectionField(
                            label: l10n.employees_positionLabel,
                            selectedName: ' ',
                            icon: Icons.work_outline,
                            items: [],
                            selectedId: state.selectedPositionId,
                            itemName: (p) => p.name,
                            itemId: (p) => p.id,
                            onSelected: (id) => context
                                .read<EmployeeFormBloc>()
                                .add(PositionChanged(id)),
                          ),
                          const SizedBox(height: 20),
                          InventorySelectionField(
                            label: l10n.employees_roomLabel,
                            selectedName: ' ',
                            icon: Icons.room_outlined,
                            items: [],
                            selectedId: state.selectedRoomId,
                            itemName: (r) => r.name,
                            itemId: (r) => r.id,
                            onSelected: (id) => context
                                .read<EmployeeFormBloc>()
                                .add(RoomChanged(id)),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () => context
                                .read<EmployeeFormBloc>()
                                .add(SubmitEmployeeForm()),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              employee == null
                                  ? l10n.common_create
                                  : l10n.common_save,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
