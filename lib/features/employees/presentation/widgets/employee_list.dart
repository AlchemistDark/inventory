import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A widget that displays a list of employees.
class EmployeeList extends StatelessWidget {
  /// Creates an [EmployeeList].
  const EmployeeList({
    required this.employees,
    required this.positionsMap,
    super.key,
  });

  /// The list of employees to display.
  final List<EmployeeEntity> employees;

  /// A map to look up position names by their ID.
  final Map<int, String> positionsMap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        final positionNames = employee.positionIds
            .map((id) => positionsMap[id] ?? l10n.employees_unknownPosition)
            .join(', ');

        return EmployeeListItem(
          employee: employee,
          positionName: positionNames.isEmpty ? l10n.employees_unknownPosition : positionNames,
        );
      },
    );
  }
}
