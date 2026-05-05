import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying detailed information about an employee.
///
/// This widget is stateless and expects the [EmployeesBloc] to be
/// triggered with [LoadEmployeeDetailsEvent] before or during navigation.
class EmployeeDetailsPage extends StatelessWidget {
  /// Creates an [EmployeeDetailsPage].
  const EmployeeDetailsPage({
    required this.employee,
    super.key,
  });

  static void _confirmDelete(BuildContext context, EmployeeEntity employee) {
    final l10n = AppLocalizations.of(context)!;
    final employeesBloc = context.read<EmployeesBloc>();
    final entityLabel = l10n.employees_nameLabel;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.common_deleteConfirmTitle(entityLabel)),
        content: Text(l10n.common_deleteConfirmContent(employee.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.common_cancel),
          ),
          TextButton(
            onPressed: () {
              employeesBloc.add(DeleteEmployeeEvent(employee.id));
              Navigator.pop(dialogContext); // Close dialog
              Navigator.pop(context); // Go back to employees list
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.common_delete),
          ),
        ],
      ),
    );
  }

  /// The employee to display details for.
  final EmployeeEntity employee;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is InventoriesLoaded) {
              context
                  .read<EmployeesBloc>()
                  .add(LoadEmployeeDetailsEvent(employee.id));
            }
          },
        ),
      ],
      child: BlocBuilder<EmployeesBloc, EmployeesState>(
        builder: (context, state) {
        EmployeeEntity currentEmployee = employee;

        if (state is EmployeesLoaded) {
          final foundEmployee = state.allEmployees
              .where((e) => e.id == employee.id)
              .firstOrNull;
          if (foundEmployee != null) {
            currentEmployee = foundEmployee;
          }
        }

        final positions = state is EmployeesLoaded ? state.positions : <PositionEntity>[];
        final rooms = state is EmployeesLoaded ? state.rooms : <RoomEntity>[];

        final positionNames = positions
            .where((p) => currentEmployee.positionIds.contains(p.id))
            .map((p) => p.name)
            .join(', ');

        final roomName = rooms.getNameById(
          currentEmployee.roomId,
          fallback: l10n.common_notDefined,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(currentEmployee.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    EmployeeFormPage.route(employee: currentEmployee),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _confirmDelete(context, currentEmployee),
              ),
            ],
          ),
          body: state is EmployeesLoaded
              ? CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      sliver: SliverToBoxAdapter(
                        child: EmployeeInfoCard(
                          positionName: positionNames.isEmpty
                              ? l10n.employees_unknownPosition
                              : positionNames,
                          roomName: roomName,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          l10n.employees_assignedInventory,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    EmployeeInventoryList(state: state),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    ),
  );
  }
}
