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

  /// Cleans the category IDs by removing duplicates.
  static List<int> cleanCategoryIds(List<int> ids, [int? _]) {
    return ids.toSet().toList();
  }

  /// Creates a copy of this [InventoryEntity] but with the given fields replaced with the new values.
  InventoryEntity copyWith({
    int? id,
    String? barcode,
    String? name,
    String? inventoryNumber,
    int? quantity,
    String? description,
    DateTime? dateAdded,
    int? employeeId,
    int? roomId,
    List<int>? categoryIds,
    DateTime? createdAt,
  }) {
    return InventoryEntity(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      inventoryNumber: inventoryNumber ?? this.inventoryNumber,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      dateAdded: dateAdded ?? this.dateAdded,
      employeeId: employeeId ?? this.employeeId,
      roomId: roomId ?? this.roomId,
      categoryIds: categoryIds ?? this.categoryIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }
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
