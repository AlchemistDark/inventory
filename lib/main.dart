import 'package:flutter/foundation.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Application entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies via service locator
  await ServiceLocator.setup();

  // Seed test inventory data in debug mode only
  if (kDebugMode) {
    await DatabaseSeeder.seedTestInventory(
      ServiceLocator.getIt<InventoryRepository>(),
    );
  }

  runApp(const MyApp());
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  /// Creates [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EmployeesLocalDataSource>(
          create: (_) => ServiceLocator.getIt<EmployeesLocalDataSource>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ServiceLocator.getIt<HomeBloc>()..add(const InitializeEvent()),
          ),
          BlocProvider(
            create: (context) => ServiceLocator.getIt<InventoryBloc>()
              ..add(const InitializeInventoriesEvent()),
          ),
          BlocProvider(
            create: (context) => ServiceLocator.getIt<InventoryFormBloc>(),
          ),
          BlocProvider(
            create: (context) => ServiceLocator.getIt<EmployeeFormBloc>(),
          ),
          BlocProvider(
            create: (context) => ServiceLocator.getIt<EmployeesBloc>()
              ..add(LoadEmployeesEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Inventory Management',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ru', 'RU'),
          theme: AppTheme.light,
          home: const HomePage(),
        ),
      ),
    );
  }
}
