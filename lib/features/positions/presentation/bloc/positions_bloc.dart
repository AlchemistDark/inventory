import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing the state and operations of the positions list.
class PositionsBloc extends Bloc<PositionsEvent, PositionsState> {
  /// Use case for retrieving positions.
  final GetPositionsUseCase getPositionsUseCase;

  /// Use case for creating a position.
  final CreatePositionUseCase createPositionUseCase;

  /// Use case for updating a position.
  final UpdatePositionUseCase updatePositionUseCase;

  /// Use case for deleting a position.
  final DeletePositionUseCase deletePositionUseCase;

  /// Creates a [PositionsBloc] with the required dependencies.
  PositionsBloc({
    required this.getPositionsUseCase,
    required this.createPositionUseCase,
    required this.updatePositionUseCase,
    required this.deletePositionUseCase,
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
      await createPositionUseCase(event.position);
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
      await updatePositionUseCase(event.position);
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
      await deletePositionUseCase(event.id);
      add(const LoadPositionsEvent());
    } catch (e) {
      emit(const PositionsError(AppFailure.database));
    }
  }
}
