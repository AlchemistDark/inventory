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

  /// The employee to display details for.
  final EmployeeEntity employee;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context, EmployeeFormPage.route(employee: employee));
            },
          ),
        ],
      ),
      body: BlocBuilder<EmployeesBloc, EmployeesState>(
        builder: (context, state) {
          if (state is EmployeesLoaded) {
            final positionName = state.positions.getNameById(
              employee.positionId,
              fallback: l10n.employees_unknownPosition,
            );

            final roomName = state.rooms.getNameById(
              employee.roomId,
              fallback: l10n.common_notDefined,
            );

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverToBoxAdapter(
                    child: EmployeeInfoCard(
                      positionName: positionName,
                      roomName: roomName,
                    ),
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      l10n.employees_assignedInventory,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                EmployeeInventoryList(state: state),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
