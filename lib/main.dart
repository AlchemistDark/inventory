import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/database/database_helper.dart';
import 'package:inventory_p_shalaev/core/database/database_seeder.dart';
import 'package:inventory_p_shalaev/features/features.dart';

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
  // ToDo Убрать потом это отсюда
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

class MyApp extends StatelessWidget {
  final InventoryRepositoryImpl inventoryRepository;
  final EmployeesLocalDataSourceImpl employeesDataSource;
  final RoomsLocalDataSourceImpl roomsDataSource;
  final PositionsLocalDataSourceImpl positionsDataSource;
  final CategoriesLocalDataSourceImpl categoriesDataSource;

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
        ],
        child: MaterialApp(
          title: 'Inventory Management',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
