import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Card widget displaying summarized employee information.
class EmployeeInfoCard extends StatelessWidget {
  /// Creates an [EmployeeInfoCard].
  const EmployeeInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            EmployeeInfoRow(
              icon: Icons.work,
              label: l10n.employees_positionLabel,
              value: ' ',
            ),
            const Divider(),
            EmployeeInfoRow(
              icon: Icons.room,
              label: l10n.employees_roomLabel,
              value: ' ',
            ),
          ],
        ),
      ),
    );
  }
}
