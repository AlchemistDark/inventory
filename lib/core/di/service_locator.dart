import 'package:get_it/get_it.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Dependency injection locator configuration.
abstract final class ServiceLocator {
  /// Global instance of GetIt for dependency injection.
  static final getIt = GetIt.instance;

  /// Sets up the dependency injection locator.
  static Future<void> setup() {
    // Database
    getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

    // Data Sources
    getIt.registerLazySingleton<CategoriesLocalDataSource>(
      () => CategoriesLocalDataSourceImpl(getIt()),
    );
    getIt.registerLazySingleton<EmployeesLocalDataSource>(
      () => EmployeesLocalDataSourceImpl(getIt()),
    );
    getIt.registerLazySingleton<InventoryLocalDataSource>(
      () => InventoryLocalDataSourceImpl(getIt()),
    );
    getIt.registerLazySingleton<PositionsLocalDataSource>(
      () => PositionsLocalDataSourceImpl(getIt()),
    );
    getIt.registerLazySingleton<RoomsLocalDataSource>(
      () => RoomsLocalDataSourceImpl(getIt()),
    );

    // Repositories
    getIt.registerLazySingleton<InventoryRepository>(
      () => InventoryRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<RoomRepository>(
      () => RoomRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<PositionRepository>(
      () => PositionRepositoryImpl(getIt()),
    );

    // Use Cases
    // Inventory
    getIt.registerLazySingleton(() => CreateInventoryUseCase(getIt()));
    getIt.registerLazySingleton(() => UpdateInventoryUseCase(getIt()));
    getIt.registerLazySingleton(() => GetInventoriesUseCase(getIt()));
    getIt.registerLazySingleton(() => SearchInventoriesByNameUseCase(getIt()));
    getIt.registerLazySingleton(() => SearchInventoryByBarcodeUseCase(getIt()));
    getIt.registerLazySingleton(() => GetInventoryByEmployeeIdUseCase(getIt()));

    // Employees
    getIt.registerLazySingleton(() => CreateEmployeeUseCase(getIt()));
    getIt.registerLazySingleton(() => UpdateEmployeeUseCase(getIt()));
    getIt.registerLazySingleton(() => GetEmployeesUseCase(getIt()));
    getIt.registerLazySingleton(() => DeleteEmployeeUseCase(getIt()));

    // Rooms
    getIt.registerLazySingleton(() => GetRoomsUseCase(getIt()));
    getIt.registerLazySingleton(() => CreateRoomUseCase(getIt()));
    getIt.registerLazySingleton(() => UpdateRoomUseCase(getIt()));
    getIt.registerLazySingleton(() => DeleteRoomUseCase(getIt()));

    // Categories
    getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt()));
    getIt.registerLazySingleton(() => CreateCategoryUseCase(getIt()));
    getIt.registerLazySingleton(() => UpdateCategoryUseCase(getIt()));
    getIt.registerLazySingleton(() => DeleteCategoryUseCase(getIt()));
    getIt.registerLazySingleton(() => SearchCategoriesUseCase(getIt()));

    // Positions
    getIt.registerLazySingleton(() => GetPositionsUseCase(getIt()));
    getIt.registerLazySingleton(() => CreatePositionUseCase(getIt()));
    getIt.registerLazySingleton(() => UpdatePositionUseCase(getIt()));
    getIt.registerLazySingleton(() => DeletePositionUseCase(getIt()));

    // BLoCs
    getIt.registerFactory(
      () => HomeBloc(
        searchByBarcodeUseCase: getIt(),
        searchByNameUseCase: getIt(),
        getInventoriesUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => InventoryBloc(
        searchByNameUseCase: getIt(),
        getInventoriesUseCase: getIt(),
        createInventoryUseCase: getIt(),
        updateInventoryUseCase: getIt(),
        getEmployeesUseCase: getIt(),
        getCategoriesUseCase: getIt(),
        getRoomsUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => InventoryFormBloc(
        getEmployeesUseCase: getIt(),
        getCategoriesUseCase: getIt(),
        getRoomsUseCase: getIt(),
        createInventoryUseCase: getIt(),
        updateInventoryUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => EmployeeFormBloc(
        getPositionsUseCase: getIt(),
        getRoomsUseCase: getIt(),
        createEmployeeUseCase: getIt(),
        updateEmployeeUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => EmployeesBloc(
        getEmployeesUseCase: getIt(),
        getPositionsUseCase: getIt(),
        getRoomsUseCase: getIt(),
        getInventoryByEmployeeIdUseCase: getIt(),
        createEmployeeUseCase: getIt(),
        updateEmployeeUseCase: getIt(),
        deleteEmployeeUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => RoomsBloc(
        getRoomsUseCase: getIt(),
        createRoomUseCase: getIt(),
        updateRoomUseCase: getIt(),
        deleteRoomUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => RoomDetailsBloc(
        getInventoriesUseCase: getIt(),
        getEmployeesUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => CategoriesBloc(
        getCategoriesUseCase: getIt(),
        createCategoryUseCase: getIt(),
        updateCategoryUseCase: getIt(),
        deleteCategoryUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => PositionsBloc(
        getPositionsUseCase: getIt(),
        createPositionUseCase: getIt(),
        updatePositionUseCase: getIt(),
        deletePositionUseCase: getIt(),
      ),
    );

    return Future.value();
  }
}
