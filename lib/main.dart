import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/database/database_helper.dart';
import 'package:inventory_p_shalaev/features/home/presentation/bloc/home_bloc.dart';
import 'package:inventory_p_shalaev/features/home/presentation/pages/home_page.dart';
import 'package:inventory_p_shalaev/features/inventory/data/datasources/inventory_local_datasource.dart';
import 'package:inventory_p_shalaev/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/usecases/inventory_usecases.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  final databaseHelper = DatabaseHelper();
  final inventoryDataSource = InventoryLocalDataSourceImpl(databaseHelper);
  final inventoryRepository = InventoryRepositoryImpl(inventoryDataSource);

  // Initialize test data
  await _initializeTestData(inventoryRepository);

  runApp(MyApp(inventoryRepository: inventoryRepository));
}

/// Initializes the database with test data
Future<void> _initializeTestData(InventoryRepositoryImpl repository) async {
  try {
    final existing = await repository.getInventories();
    if (existing.isEmpty) {
      await repository.createInventory(
        InventoryEntity(
          id: 0,
          barcode: 'BARCODE001',
          name: 'Dell Laptop',
          inventoryNumber: 'INV-001',
          quantity: 1,
          description: 'Laptop for office',
          dateAdded: DateTime.now(),
          employeeId: null,
          roomId: null,
          createdAt: DateTime.now(),
        ),
      );

      await repository.createInventory(
        InventoryEntity(
          id: 0,
          barcode: 'BARCODE002',
          name: 'LG Monitor',
          inventoryNumber: 'INV-002',
          quantity: 2,
          description: '24-inch monitor',
          dateAdded: DateTime.now(),
          employeeId: null,
          roomId: null,
          createdAt: DateTime.now(),
        ),
      );

      await repository.createInventory(
        InventoryEntity(
          id: 0,
          barcode: 'BARCODE003',
          name: 'Logitech Keyboard',
          inventoryNumber: 'INV-003',
          quantity: 3,
          description: 'Mechanical keyboard',
          dateAdded: DateTime.now(),
          employeeId: null,
          roomId: null,
          createdAt: DateTime.now(),
        ),
      );
    }
  } catch (e) {
    debugPrint('Error initializing test data: $e');
  }
}

class MyApp extends StatelessWidget {
  final InventoryRepositoryImpl inventoryRepository;

  const MyApp({super.key, required this.inventoryRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(
          searchByBarcodeUseCase: SearchInventoryByBarcodeUseCase(
            inventoryRepository,
          ),
          searchByNameUseCase: SearchInventoriesByNameUseCase(
            inventoryRepository,
          ),
          getInventoriesUseCase: GetInventoriesUseCase(inventoryRepository),
        ),
        child: const HomePage(),
      ),
    );
  }
}
