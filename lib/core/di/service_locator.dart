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
    getIt.registerLazySingleton<EmployeesLocalDataSource>(
      () => EmployeesLocalDataSourceImpl(getIt()),
    );
    getIt.registerLazySingleton<InventoryLocalDataSource>(
      () => InventoryLocalDataSourceImpl(getIt()),
    );

    // Repositories
    getIt.registerLazySingleton<InventoryRepository>(
      () => InventoryRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(getIt()),
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
        employeesDataSource: getIt(),
      ),
    );

    getIt.registerFactory(
      () => InventoryFormBloc(
        employeesDataSource: getIt(),
        createInventoryUseCase: getIt(),
        updateInventoryUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => EmployeeFormBloc(
        createEmployeeUseCase: getIt(),
        updateEmployeeUseCase: getIt(),
      ),
    );

    getIt.registerFactory(
      () => EmployeesBloc(
        getEmployeesUseCase: getIt(),
        getInventoryByEmployeeIdUseCase: getIt(),
        createEmployeeUseCase: getIt(),
        updateEmployeeUseCase: getIt(),
        deleteEmployeeUseCase: getIt(),
      ),
    );

    return Future.value();
  }
}
