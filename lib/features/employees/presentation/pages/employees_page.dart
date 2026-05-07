import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Main page for managing employees.
///
/// Displays a searchable and filterable list of employees,
/// allowing navigation to employee details and creation forms.
class EmployeesPage extends StatelessWidget {
  /// Creates an [EmployeesPage].
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home_employeesButton),
      ),
      body: BlocBuilder<EmployeesBloc, EmployeesState>(
        builder: (context, state) {
          if (state is EmployeesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeesLoaded) {
            final positionsMap = {
              for (final p in state.positions) p.id: p.name,
            };

            return Column(
              children: [
                EmployeesSearchAndFilter(
                    positionFilter: state.positionFilter,
                    positions: state.positions,
                ),
                Expanded(
                  child: state.filteredEmployees.isEmpty
                      ? Center(child: Text(l10n.employees_notFound))
                      : EmployeeList(
                          employees: state.filteredEmployees,
                          positionsMap: positionsMap,
                        ),
                ),
              ],
            );
          }

          if (state is EmployeesError) {
            return Center(
                child: Text(
                    l10n.common_error(state.failure.toLocalizedString(l10n))));
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, EmployeeFormPage.route());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
