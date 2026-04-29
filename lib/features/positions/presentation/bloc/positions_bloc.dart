import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing the state and operations of the positions list.
class PositionsBloc extends Bloc<PositionsEvent, PositionsState> {
  /// Use case for retrieving positions.
  final GetPositionsUseCase getPositionsUseCase;

  /// Repository for other position operations (create, update, delete).
  final PositionRepository repository;

  /// Creates a [PositionsBloc] with the required dependencies.
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
