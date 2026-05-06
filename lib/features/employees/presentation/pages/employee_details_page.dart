import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
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

  static void _confirmDelete(BuildContext context, EmployeeEntity employee) async {
    final l10n = AppLocalizations.of(context)!;
    final employeesBloc = context.read<EmployeesBloc>();

    final confirmed = await AppDialogs.showDeleteConfirmation(
      context: context,
      entityName: employee.name,
      entityTypeLabel: l10n.employees_nameLabel,
    );

    if (confirmed == true) {
      employeesBloc.add(DeleteEmployeeEvent(employee.id));
      if (context.mounted) {
        Navigator.pop(context); // Go back to employees list
      }
    }
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
