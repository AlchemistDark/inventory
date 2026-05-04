import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

/// Data model representing an inventory item for data layer operations
///
/// Used for database operations and data transfer between layers
class InventoryModel {
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

  /// Creates an [InventoryModel] with the given parameters
  InventoryModel({
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

  /// Creates an [InventoryModel] from a database map
  factory InventoryModel.fromMap(Map<String, dynamic> map, {List<int> categoryIds = const []}) {
    return InventoryModel(
      id: map['id'] as int,
      barcode: map['barcode'] as String?,
      name: map['name'] as String,
      inventoryNumber: map['inventoryNumber'] as String?,
      quantity: map['quantity'] as int? ?? 1,
      description: map['description'] as String?,
      dateAdded: DateTime.fromMillisecondsSinceEpoch(map['dateAdded'] as int),
      employeeId: map['employeeId'] as int?,
      roomId: map['roomId'] as int?,
      categoryIds: categoryIds,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  /// Creates an [InventoryModel] from a domain entity
  factory InventoryModel.fromEntity(InventoryEntity entity) {
    return InventoryModel(
      id: entity.id,
      barcode: entity.barcode,
      name: entity.name,
      inventoryNumber: entity.inventoryNumber,
      quantity: entity.quantity,
      description: entity.description,
      dateAdded: entity.dateAdded,
      employeeId: entity.employeeId,
      roomId: entity.roomId,
      categoryIds: entity.categoryIds,
      createdAt: entity.createdAt,
    );
  }

  /// Creates an [InventoryModel] from JSON
  factory InventoryModel.fromJson(Map<String, dynamic> json) =>
      InventoryModel.fromMap(
        json,
        categoryIds: List<int>.of(
          (json['categoryIds'] as List? ?? []).cast<int>(),
        ),
      );

  /// Converts the model to a database map (excluding many-to-many categories)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'name': name,
      'inventoryNumber': inventoryNumber,
      'quantity': quantity,
      'description': description,
      'dateAdded': dateAdded.millisecondsSinceEpoch,
      'employeeId': employeeId,
      'roomId': roomId,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  /// Converts the model to JSON including categoryIds
  Map<String, dynamic> toJson() {
    final map = toMap();
    map['categoryIds'] = categoryIds;

    return map;
  }

  /// Converts the model to a domain entity
  InventoryEntity toEntity() {
    return InventoryEntity(
      id: id,
      barcode: barcode,
      name: name,
      inventoryNumber: inventoryNumber,
      quantity: quantity,
      description: description,
      dateAdded: dateAdded,
      employeeId: employeeId,
      roomId: roomId,
      categoryIds: categoryIds,
      createdAt: createdAt,
    );
  }

  /// Converts model to a map for database insertion/update in the 'inventory' table.
  /// Note: 'categoryId' is stored in a separate join table.
  Map<String, dynamic> toDbMap() {
    return {
      if (id > 0) 'id': id,
      'barcode': barcode,
      'name': name,
      'inventoryNumber': inventoryNumber,
      'quantity': quantity,
      'description': description,
      'dateAdded': dateAdded.millisecondsSinceEpoch,
      'employeeId': employeeId,
      'roomId': roomId,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}

