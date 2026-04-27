import 'package:inventory_p_shalaev/features/features.dart';

/// Base class for all events related to the inventory creation and editing form.
abstract class InventoryFormEvent extends Equatable {
  @override
  List<Object?> get props => [];

  /// Creates an [InventoryFormEvent].
  const InventoryFormEvent();
}

/// Event to load metadata required by the form (employees, categories, rooms).
class LoadFormMetadataEvent extends InventoryFormEvent {
  /// Creates a [LoadFormMetadataEvent].
  const LoadFormMetadataEvent();
}

/// Event to submit the inventory form for either creation or updating.
class SubmitInventoryEvent extends InventoryFormEvent {
  /// The inventory entity data to be saved.
  final InventoryEntity inventory;

  /// Flag indicating whether this is an edit operation (true) or a new item creation (false).
  final bool isEdit;

  @override
  List<Object?> get props => [inventory, isEdit];

  /// Creates a [SubmitInventoryEvent] with the given [inventory] and [isEdit] flag.
  const SubmitInventoryEvent({
    required this.inventory,
    required this.isEdit,
  });
}
