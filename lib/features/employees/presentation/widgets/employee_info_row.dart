import 'package:flutter/material.dart';

/// A single row of information within the employee details.
class EmployeeInfoRow extends StatelessWidget {
  /// Creates an [EmployeeInfoRow].
  const EmployeeInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  /// Icon representing the type of information.
  final IconData icon;

  /// Label for the information.
  final String label;

  /// The value of the information to display.
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
              ),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
