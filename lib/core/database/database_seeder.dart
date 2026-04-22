import 'package:flutter/foundation.dart';
import '../../features/inventory/data/repositories/inventory_repository_impl.dart';
import '../../features/employees/data/datasources/employees_local_datasource.dart';
import '../../features/rooms/data/datasources/rooms_local_datasource.dart';
import '../../features/positions/data/datasources/positions_local_datasource.dart';
import '../../features/categories/data/datasources/categories_local_datasource.dart';

import '../../features/categories/data/models/category_model.dart';
import '../../features/positions/data/models/position_model.dart';
import '../../features/rooms/data/models/room_model.dart';
import '../../features/employees/data/models/employee_model.dart';
import '../../features/inventory/domain/entities/inventory_entity.dart';

class DatabaseSeeder {
  /// Initializes the database with test data
  static Future<void> seedTestData(
    InventoryRepositoryImpl inventoryRepository,
    EmployeesLocalDataSourceImpl employeesDataSource,
    RoomsLocalDataSourceImpl roomsDataSource,
    PositionsLocalDataSourceImpl positionsDataSource,
    CategoriesLocalDataSourceImpl categoriesDataSource,
  ) async {
    try {
      // Initialize categories if empty
      final categories = await categoriesDataSource.getCategories();
      if (categories.isEmpty) {
        await categoriesDataSource.createCategory('Не определено');
      }

      // Initialize positions
      final positions = await positionsDataSource.getPositions();
      if (positions.isEmpty) {
        await positionsDataSource.createPosition(
          PositionModel(
            id: 0,
            name: 'Администратор',
            createdAt: DateTime.now(),
          ),
        );
      }

      // Initialize rooms
      final rooms = await roomsDataSource.getRooms();
      if (rooms.isEmpty) {
        await roomsDataSource.createRoom(
          RoomModel(
            id: 0,
            name: 'Не определено',
            description: 'Default room',
            createdAt: DateTime.now(),
          ),
        );
      }

      // Initialize employees
      final employees = await employeesDataSource.getEmployees();
      if (employees.isEmpty) {
        await employeesDataSource.createEmployee(
          EmployeeModel(
            id: 0,
            name: 'Администратор',
            positionId: 1,
            roomId: 1,
            createdAt: DateTime.now(),
          ),
        );
      }

      // Initialize inventory
      final existing = await inventoryRepository.getInventories();
      if (existing.isEmpty) {
        await inventoryRepository.createInventory(
          InventoryEntity(
            id: 0,
            barcode: 'BARCODE001',
            name: 'Dell Laptop',
            inventoryNumber: 'INV-001',
            quantity: 1,
            description: 'Laptop for office',
            dateAdded: DateTime.now(),
            employeeId: 1,
            roomId: 1,
            createdAt: DateTime.now(),
          ),
        );

        await inventoryRepository.createInventory(
          InventoryEntity(
            id: 0,
            barcode: 'BARCODE002',
            name: 'LG Monitor',
            inventoryNumber: 'INV-002',
            quantity: 2,
            description: '24-inch monitor',
            dateAdded: DateTime.now(),
            employeeId: 1,
            roomId: 1,
            createdAt: DateTime.now(),
          ),
        );

        await inventoryRepository.createInventory(
          InventoryEntity(
            id: 0,
            barcode: 'BARCODE003',
            name: 'Logitech Keyboard',
            inventoryNumber: 'INV-003',
            quantity: 3,
            description: 'Mechanical keyboard',
            dateAdded: DateTime.now(),
            employeeId: 1,
            roomId: 1,
            createdAt: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error initializing test data: $e');
    }
  }
}
