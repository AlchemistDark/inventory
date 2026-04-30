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

  // Load localizations for seeding default data
  // We use the default 'ru' locale as defined in MaterialApp
  final l10n = await AppLocalizations.delegate.load(const Locale('ru', 'RU'));

  // Initialize default data (categories, positions, rooms, admin employee)
  await DatabaseSeeder.seedDefaults(
    ServiceLocator.getIt<EmployeesLocalDataSource>(),
    ServiceLocator.getIt<RoomsLocalDataSource>(),
    ServiceLocator.getIt<PositionsLocalDataSource>(),
    ServiceLocator.getIt<CategoriesLocalDataSource>(),
    l10n,
  );

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
        RepositoryProvider<RoomsLocalDataSource>(
          create: (_) => ServiceLocator.getIt<RoomsLocalDataSource>(),
        ),
        RepositoryProvider<PositionsLocalDataSource>(
          create: (_) => ServiceLocator.getIt<PositionsLocalDataSource>(),
        ),
        RepositoryProvider<CategoriesLocalDataSource>(
          create: (_) => ServiceLocator.getIt<CategoriesLocalDataSource>(),
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
            create: (context) => ServiceLocator.getIt<EmployeesBloc>()
              ..add(LoadEmployeesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                ServiceLocator.getIt<RoomsBloc>()..add(const LoadRoomsEvent()),
          ),
          BlocProvider(
            create: (context) => ServiceLocator.getIt<CategoriesBloc>()
              ..add(const LoadCategoriesEvent()),
          ),
          BlocProvider(
            create: (context) => ServiceLocator.getIt<PositionsBloc>()
              ..add(const LoadPositionsEvent()),
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
