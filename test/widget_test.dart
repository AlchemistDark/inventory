import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_p_shalaev/main.dart';
import 'package:inventory_p_shalaev/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:inventory_p_shalaev/features/inventory/data/datasources/inventory_local_datasource.dart';
import 'package:inventory_p_shalaev/core/database/database_helper.dart';
import 'package:inventory_p_shalaev/features/employees/data/datasources/employees_local_datasource.dart';
import 'package:inventory_p_shalaev/features/rooms/data/datasources/rooms_local_datasource.dart';
import 'package:inventory_p_shalaev/features/positions/data/datasources/positions_local_datasource.dart';
import 'package:inventory_p_shalaev/features/categories/data/datasources/categories_local_datasource.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final databaseHelper = DatabaseHelper();
    final inventoryDataSource = InventoryLocalDataSourceImpl(databaseHelper);
    final inventoryRepository = InventoryRepositoryImpl(inventoryDataSource);
    
    final employeesDataSource = EmployeesLocalDataSourceImpl(databaseHelper);
    final roomsDataSource = RoomsLocalDataSourceImpl(databaseHelper);
    final positionsDataSource = PositionsLocalDataSourceImpl(databaseHelper);
    final categoriesDataSource = CategoriesLocalDataSourceImpl(databaseHelper);

    await tester.pumpWidget(MyApp(
      inventoryRepository: inventoryRepository,
      employeesDataSource: employeesDataSource,
      roomsDataSource: roomsDataSource,
      positionsDataSource: positionsDataSource,
      categoriesDataSource: categoriesDataSource,
    ));

    // Verify that the app title is displayed (you may need to adjust based on exact UI)
    // expect(find.text('Inventory Management'), findsOneWidget);
  });
}
