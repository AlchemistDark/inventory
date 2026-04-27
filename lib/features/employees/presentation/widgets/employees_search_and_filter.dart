import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Widget providing search and position-based filtering for the employees list.
class EmployeesSearchAndFilter extends StatelessWidget {
  /// Creates an [EmployeesSearchAndFilter].
  const EmployeesSearchAndFilter({required this.state, super.key});

  /// The current state of [EmployeesBloc] containing available positions and filters.
  final EmployeesLoaded state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
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
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              FilterChip(
                label: Text(l10n.common_all),
                selected: state.positionFilter == null,
                onSelected: (_) {
                  context.read<EmployeesBloc>().add(
                        const FilterEmployeesByPositionEvent(null),
                      );
                },
              ),
              const SizedBox(width: 8),

            ],
          ),
        ),
      ],
    );
  }
}
