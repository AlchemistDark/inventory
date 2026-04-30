import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A tab view displaying the list of employees assigned to a specific room.
class RoomEmployeesTab extends StatelessWidget {
  /// Creates a [RoomEmployeesTab].
  const RoomEmployeesTab({
    required this.employees,
    required this.positions,
    super.key,
  });

  /// The list of employees to display.
  final List<EmployeeEntity> employees;

  /// List of positions to lookup names.
  final List<PositionEntity> positions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (employees.isEmpty) {
      return Center(child: Text(l10n.rooms_noEmployees));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        final positionNames = employee.positionIds
            .map(
              (id) => positions.getNameById(
                id,
                fallback: l10n.employees_unknownPosition,
              ),
            )
            .join(', ');

        final displayPosition = positionNames.isEmpty
            ? l10n.employees_unknownPosition
            : positionNames;

        return EmployeeListItem(
          employee: employee,
          positionName: displayPosition,
        );
      },
    );
  }
}
