import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Widget providing search and position-based filtering for the employees list.
class EmployeesSearchAndFilter extends StatelessWidget {
  /// Creates an [EmployeesSearchAndFilter].
  const EmployeesSearchAndFilter({
    required this.positionFilter,
    required this.positions,
    super.key,
  });

  final int? positionFilter;

  final List<PositionEntity> positions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: l10n.employees_searchHint,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              context.read<EmployeesBloc>().add(SearchEmployeesEvent(value));
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int?>(
            initialValue: positionFilter,
            decoration: InputDecoration(
              labelText: l10n.employees_positionLabel,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: [
              DropdownMenuItem(
                value: null,
                child: Text(l10n.common_all),
              ),
              ...positions.map(
                (position) => DropdownMenuItem(
                  value: position.id,
                  child: Text(position.name),
                ),
              ),
            ],
            onChanged: (value) {
              context.read<EmployeesBloc>().add(
                    FilterEmployeesByPositionEvent(value),
                  );
            },
          ),
        ],
      ),
    );
  }
}
