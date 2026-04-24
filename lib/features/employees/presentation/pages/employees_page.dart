import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/app_localizations.dart';
import '../../presentation/bloc/employees_bloc.dart';
import '../../presentation/bloc/employees_event.dart';
import '../../presentation/bloc/employees_state.dart';

class EmployeesPage extends StatelessWidget {
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
          } else if (state is EmployeesLoaded) {
            if (state.employees.isEmpty) {
              return const Center(child: Text('Список сотрудников пуст'));
            }
            return ListView.builder(
              itemCount: state.employees.length,
              itemBuilder: (context, index) {
                final employee = state.employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text('ID: ${employee.id}'),
                  leading: const Icon(Icons.person),
                );
              },
            );
          } else if (state is EmployeesError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          }
          return const Center(child: Text('Нажмите для загрузки'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement create employee dialog
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Создание сотрудника в разработке')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
