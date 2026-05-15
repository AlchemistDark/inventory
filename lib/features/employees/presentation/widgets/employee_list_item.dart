import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// List item widget representing an employee in the employees list.
class EmployeeListItem extends StatelessWidget {
  /// Creates an [EmployeeListItem].
  const EmployeeListItem({
    required this.employee,
    required this.positionName,
    super.key,
  });

  /// The employee entity to display.
  final EmployeeEntity employee;

  /// The formatted name of the employee's position.
  final String positionName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        employee.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        positionName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context
            .read<EmployeesBloc>()
            .add(LoadEmployeeDetailsEvent(employee.id));
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => EmployeeDetailsPage(employee: employee),
          ),
        );
      },
    );
  }
}
