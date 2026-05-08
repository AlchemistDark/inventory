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
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;

        return BlocProvider(
          create: (_) =>
              ServiceLocator.getIt<EmployeeFormBloc>()
                ..add(InitializeEmployeeForm(employee: employee, l10n: l10n)),
          child: EmployeeFormPage(employee: employee),
        );
      },
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
              backgroundColor: Theme.of(context).colorScheme.secondary,
              content: Text(
                employee == null
                    ? l10n.employees_created
                    : l10n.employees_updated,
              ),
            ),
          );
        } else if (state is EmployeeFormValidationFailed) {
          final message = switch (state.error) {
            EmployeeFormValidationError.positionRequired =>
              l10n.employees_selectPosition,
          };
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        } else if (state is EmployeeFormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure.toLocalizedString(l10n))),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              employee == null
                  ? l10n.employees_createTitle
                  : l10n.employees_editTitle,
            ),
          ),
          body: state is EmployeeFormLoading
              ? const Center(child: CircularProgressIndicator())
              : state is EmployeeFormMetadataLoaded
              ? EmployeeForm(
                  nameError: state.nameError,
                  positions: state.positions,
                  selectedPositionIds: state.selectedPositionIds,
                  rooms: state.rooms,
                  selectedRoomId: state.selectedRoomId,
                  employee: employee,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
