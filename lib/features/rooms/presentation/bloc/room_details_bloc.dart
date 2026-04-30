import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing room details (inventory and employees)
class RoomDetailsBloc extends Bloc<RoomDetailsEvent, RoomDetailsState> {
  /// Use case to fetch all inventories
  final GetInventoriesUseCase getInventoriesUseCase;

  /// Use case to fetch all employees
  final GetEmployeesUseCase getEmployeesUseCase;

  /// Creates a [RoomDetailsBloc] with required use cases
  RoomDetailsBloc({
    required this.getInventoriesUseCase,
    required this.getEmployeesUseCase,
  }) : super(const RoomDetailsInitial()) {
    on<LoadRoomDetailsEvent>(_onLoadDetails);
  }

  Future<void> _onLoadDetails(
    LoadRoomDetailsEvent event,
    Emitter<RoomDetailsState> emit,
  ) async {
    emit(const RoomDetailsLoading());
    try {
      final allInventory = await getInventoriesUseCase();
      final allEmployees = await getEmployeesUseCase();

      final roomInventory = allInventory.filterByRoom(event.roomId);
      final roomEmployees = allEmployees.filterByRoom(event.roomId);

      emit(RoomDetailsLoaded(
        inventory: roomInventory,
        employees: roomEmployees,
      ));
    } catch (e) {
      emit(const RoomDetailsError(AppFailure.database));
    }
  }
}
