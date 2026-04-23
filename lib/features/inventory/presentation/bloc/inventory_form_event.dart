import 'package:inventory_p_shalaev/features/features.dart';

abstract class InventoryFormEvent extends Equatable {
  const InventoryFormEvent();

  @override
  List<Object?> get props => [];
}

class LoadFormMetadataEvent extends InventoryFormEvent {
  const LoadFormMetadataEvent();
}

class SubmitInventoryEvent extends InventoryFormEvent {
  final InventoryEntity inventory;
  final bool isEdit;

  const SubmitInventoryEvent({
    required this.inventory,
    required this.isEdit,
  });

  @override
  List<Object?> get props => [inventory, isEdit];
}
