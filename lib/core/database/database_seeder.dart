import 'package:flutter/foundation.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Utility class for seeding data into the database
///
/// Provides methods for initializing default records needed by the application.
class DatabaseSeeder {
  /// Initializes default data required for the application to function
  ///
  /// Creates default records for categories, positions, rooms, and an
  /// administrator employee if their respective tables are empty.
  /// This should always run regardless of build mode.
  static Future<void> seedDefaults(
    EmployeesLocalDataSource employeesDataSource,
    RoomsLocalDataSource roomsDataSource,
    PositionsLocalDataSource positionsDataSource,
    CategoriesLocalDataSource categoriesDataSource,
    AppLocalizations l10n,
  ) async {
    try {
      // Initialize default category if empty
      final categories = await categoriesDataSource.getCategories();
      if (categories.isEmpty) {
        await categoriesDataSource.createCategory(l10n.common_notDefined);
      }

      // Initialize default position if empty
      final positions = await positionsDataSource.getPositions();
      if (positions.isEmpty) {
        await positionsDataSource.createPosition(
          PositionModel(
            id: 0,
            name: l10n.common_administrator,
            createdAt: DateTime.now(),
          ),
        );
      }

      // Initialize default room if empty
      final rooms = await roomsDataSource.getRooms();
      if (rooms.isEmpty) {
        await roomsDataSource.createRoom(
          RoomModel(
            id: 0,
            name: l10n.common_notDefined,
            description: l10n.rooms_defaultDescription,
            createdAt: DateTime.now(),
          ),
        );
      }

      // Initialize default employee if empty
      final employees = await employeesDataSource.getEmployees();
      if (employees.isEmpty) {
        await employeesDataSource.createEmployee(
          EmployeeModel(
            id: 0,
            name: l10n.common_administrator,
            positionIds: const [1],
            roomId: 1,
            createdAt: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error initializing default data: $e');
    }
  }
}
