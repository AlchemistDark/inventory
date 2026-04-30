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

  /// IDs of the categories
  final List<int> categoryIds;

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
    categoryIds,
    createdAt,
  ];

  /// Creates an [InventoryEntity] with the given parameters
  const InventoryEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.dateAdded,
    required this.createdAt,
    required this.categoryIds,
    this.barcode,
    this.inventoryNumber,
    this.description,
    this.employeeId,
    this.roomId,
  });
}

/// Extension methods for [InventoryEntity] collections
extension InventoryListX on Iterable<InventoryEntity> {
  /// Finds an inventory item by its [id]
  InventoryEntity? getById(int id) {
    for (final item in this) {
      if (item.id == id) {
        return item;
      }
    }

    return null;
  }

  /// Filters the inventory items by [categoryId]
  List<InventoryEntity> filterByCategory(int? categoryId) {
    if (categoryId == null) {
      return toList();
    }

    return where((item) => item.categoryIds.contains(categoryId)).toList();
  }

  /// Filters the inventory items by [roomId]
  List<InventoryEntity> filterByRoom(int roomId) {
    return where((item) => item.roomId == roomId).toList();
  }
}
