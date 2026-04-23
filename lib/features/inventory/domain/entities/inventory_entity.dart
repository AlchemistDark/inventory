import 'package:equatable/equatable.dart';

/// Domain entity representing an inventory item
///
/// Contains all information about an inventory item including
/// identification, location, and responsibility data
class InventoryEntity extends Equatable {
  /// Unique identifier of the inventory item
  final int id;

  /// Barcode of the item (optional)
  final String? barcode;

  /// Name of the inventory item
  final String name;

  /// Inventory number (optional)
  final String? inventoryNumber;

  /// Quantity of items
  final int quantity;

  /// Description of the item (optional)
  final String? description;

  /// Date when the item was added
  final DateTime dateAdded;

  /// ID of the responsible employee (optional)
  final int? employeeId;

  /// ID of the room where item is located (optional)
  final int? roomId;

  /// ID of the category (optional)
  final int? categoryId;

  /// Timestamp of record creation
  final DateTime createdAt;

  @override
  List<Object?> get props => [
    id,
    barcode,
    name,
    inventoryNumber,
    quantity,
    description,
    dateAdded,
    employeeId,
    roomId,
    categoryId,
    createdAt,
  ];

  /// Creates an [InventoryEntity] with the given parameters
  const InventoryEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.dateAdded,
    required this.createdAt,
    this.barcode,
    this.inventoryNumber,
    this.description,
    this.employeeId,
    this.roomId,
    this.categoryId,
  });
}
