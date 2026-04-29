import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/positions/domain/repositories/position_repository.dart';
import 'package:inventory_p_shalaev/features/positions/domain/usecases/get_positions_usecase.dart';
import 'package:inventory_p_shalaev/features/positions/presentation/bloc/positions_event.dart';
import 'package:inventory_p_shalaev/features/positions/presentation/bloc/positions_state.dart';

class PositionsBloc extends Bloc<PositionsEvent, PositionsState> {
  final GetPositionsUseCase getPositionsUseCase;
  final PositionRepository repository;

  PositionsBloc({
    required this.getPositionsUseCase,
    required this.repository,
  }) : super(const PositionsInitial()) {
    on<LoadPositionsEvent>(_onLoadPositions);
    on<CreatePositionEvent>(_onCreatePosition);
    on<UpdatePositionEvent>(_onUpdatePosition);
    on<DeletePositionEvent>(_onDeletePosition);
  }

  Future<void> _onLoadPositions(
    LoadPositionsEvent event,
    Emitter<PositionsState> emit,
  ) async {
    emit(const PositionsLoading());
    try {
      final positions = await getPositionsUseCase();
      emit(PositionsLoaded(positions));
    } catch (e) {
      emit(const PositionsError(AppFailure.database));
    }
  }

  Future<void> _onCreatePosition(
    CreatePositionEvent event,
    Emitter<PositionsState> emit,
  ) async {
    try {
      await repository.createPosition(event.position);
      add(const LoadPositionsEvent());
    } catch (e) {
      emit(const PositionsError(AppFailure.database));
    }
  }

  Future<void> _onUpdatePosition(
    UpdatePositionEvent event,
    Emitter<PositionsState> emit,
  ) async {
    try {
      await repository.updatePosition(event.position);
      add(const LoadPositionsEvent());
    } catch (e) {
      emit(const PositionsError(AppFailure.database));
    }
  }

  Future<void> _onDeletePosition(
    DeletePositionEvent event,
    Emitter<PositionsState> emit,
  ) async {
    try {
      await repository.deletePosition(event.id);
      add(const LoadPositionsEvent());
    } catch (e) {
      emit(const PositionsError(AppFailure.database));
    }
  }
}
