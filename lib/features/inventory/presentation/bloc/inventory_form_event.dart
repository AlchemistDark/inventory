import 'package:inventory_p_shalaev/features/features.dart';

abstract class InventoryFormEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const InventoryFormEvent();
}

class LoadFormMetadataEvent extends InventoryFormEvent {
  const LoadFormMetadataEvent();
}

class SubmitInventoryEvent extends InventoryFormEvent {
  final InventoryEntity inventory;
  final bool isEdit;

  @override
  List<Object?> get props => [inventory, isEdit];

  const SubmitInventoryEvent({
    required this.inventory,
    required this.isEdit,
  });
}
