import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Application entry point
///
/// Initializes database, data sources, repositories, and dependency injection
/// before running the app with test data seeding
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  final databaseHelper = DatabaseHelper();
  final inventoryDataSource = InventoryLocalDataSourceImpl(databaseHelper);
  final inventoryRepository = InventoryRepositoryImpl(inventoryDataSource);

  final employeesDataSource = EmployeesLocalDataSourceImpl(databaseHelper);
  final roomsDataSource = RoomsLocalDataSourceImpl(databaseHelper);
  final positionsDataSource = PositionsLocalDataSourceImpl(databaseHelper);
  final categoriesDataSource = CategoriesLocalDataSourceImpl(databaseHelper);

  // Initialize test data
  // TODO(shalaev): Remove this later
  await DatabaseSeeder.seedTestData(
    inventoryRepository,
    employeesDataSource,
    roomsDataSource,
    positionsDataSource,
    categoriesDataSource,
  );

  runApp(
    MyApp(
      inventoryRepository: inventoryRepository,
      employeesDataSource: employeesDataSource,
      roomsDataSource: roomsDataSource,
      positionsDataSource: positionsDataSource,
      categoriesDataSource: categoriesDataSource,
    ),
  );
}

/// Root widget of the application
///
/// Configures providers, repositories, BLoCs, and navigation
class MyApp extends StatelessWidget {
  /// Repository for inventory data operations
  final InventoryRepositoryImpl inventoryRepository;

  /// Data source for employee data
  final EmployeesLocalDataSourceImpl employeesDataSource;

  /// Data source for room data
  final RoomsLocalDataSourceImpl roomsDataSource;

  /// Data source for position data
  final PositionsLocalDataSourceImpl positionsDataSource;

  /// Data source for category data
  final CategoriesLocalDataSourceImpl categoriesDataSource;

  /// Creates [MyApp] with required dependencies
  const MyApp({
    required this.inventoryRepository,
    required this.employeesDataSource,
    required this.roomsDataSource,
    required this.positionsDataSource,
    required this.categoriesDataSource,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EmployeesLocalDataSourceImpl>(
          create: (_) => employeesDataSource,
        ),
        RepositoryProvider<RoomsLocalDataSourceImpl>(
          create: (_) => roomsDataSource,
        ),
        RepositoryProvider<PositionsLocalDataSourceImpl>(
          create: (_) => positionsDataSource,
        ),
        RepositoryProvider<CategoriesLocalDataSourceImpl>(
          create: (_) => categoriesDataSource,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(
              searchByBarcodeUseCase: SearchInventoryByBarcodeUseCase(
                inventoryRepository,
              ),
              searchByNameUseCase: SearchInventoriesByNameUseCase(
                inventoryRepository,
              ),
              getInventoriesUseCase: GetInventoriesUseCase(inventoryRepository),
            ),
          ),
          BlocProvider(
            create: (context) => InventoryBloc(
              searchByNameUseCase: SearchInventoriesByNameUseCase(
                inventoryRepository,
              ),
              getInventoriesUseCase: GetInventoriesUseCase(inventoryRepository),
              createInventoryUseCase: CreateInventoryUseCase(
                inventoryRepository,
              ),
              updateInventoryUseCase: UpdateInventoryUseCase(
                inventoryRepository,
              ),
              employeesDataSource: employeesDataSource,
              categoriesDataSource: categoriesDataSource,
              roomsDataSource: roomsDataSource,
            )..add(const InitializeInventoriesEvent()),
          ),
          BlocProvider(
            create: (context) => InventoryFormBloc(
              employeesDataSource: employeesDataSource,
              categoriesDataSource: categoriesDataSource,
              roomsDataSource: roomsDataSource,
              createInventoryUseCase: CreateInventoryUseCase(inventoryRepository),
              updateInventoryUseCase: UpdateInventoryUseCase(inventoryRepository),
            ),
          ),
          BlocProvider(
            create: (context) {
              final employeeRepo = EmployeeRepositoryImpl(employeesDataSource);

              return EmployeesBloc(
                getEmployeesUseCase: GetEmployeesUseCase(employeeRepo),
                createEmployeeUseCase: CreateEmployeeUseCase(employeeRepo),
                updateEmployeeUseCase: UpdateEmployeeUseCase(employeeRepo),
                deleteEmployeeUseCase: DeleteEmployeeUseCase(employeeRepo),
              )..add(LoadEmployeesEvent());
            },
          ),
          BlocProvider(
            create: (context) {
              final roomRepo = RoomRepositoryImpl(roomsDataSource);

              return RoomsBloc(
                getRoomsUseCase: GetRoomsUseCase(roomRepo),
                repository: roomRepo,
              )..add(LoadRoomsEvent());
            },
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
