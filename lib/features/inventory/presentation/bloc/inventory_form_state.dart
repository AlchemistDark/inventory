import 'package:inventory_p_shalaev/features/features.dart';

abstract class InventoryFormState extends Equatable {
  @override
  List<Object?> get props => [];

  const InventoryFormState();
}

class InventoryFormInitial extends InventoryFormState {
  const InventoryFormInitial();
}

class InventoryFormLoading extends InventoryFormState {
  const InventoryFormLoading();
}

class InventoryFormMetadataLoaded extends InventoryFormState {
  final List<EmployeeModel> employees;
  final List<CategoryModel> categories;
  final List<RoomModel> rooms;
  final int? defaultEmployeeId;
  final int? defaultCategoryId;
  final int? defaultRoomId;

  @override
  List<Object?> get props => [
        employees,
        categories,
        rooms,
        defaultEmployeeId,
        defaultCategoryId,
        defaultRoomId,
      ];

  const InventoryFormMetadataLoaded({
    required this.employees,
    required this.categories,
    required this.rooms,
    this.defaultEmployeeId,
    this.defaultCategoryId,
    this.defaultRoomId,
  });
}

class InventoryFormSuccess extends InventoryFormState {
  const InventoryFormSuccess();
}

class InventoryFormError extends InventoryFormState {
  final String message;

  @override
  List<Object?> get props => [message];

  const InventoryFormError(this.message);
}
