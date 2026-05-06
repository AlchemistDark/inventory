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
      // We no longer seed "Not Defined" for categories and rooms.
      // They are handled as null/empty in the UI.

      // Initialize default position if empty (Administrator is a real role)
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

      // Initialize default employee if empty
      final employees = await employeesDataSource.getEmployees();
      if (employees.isEmpty) {
        await employeesDataSource.createEmployee(
          EmployeeModel(
            id: 0,
            name: l10n.common_administrator,
            positionIds: const [1],
            roomId: null, // No room by default
            createdAt: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error initializing default data: $e');
    }
  }
}
