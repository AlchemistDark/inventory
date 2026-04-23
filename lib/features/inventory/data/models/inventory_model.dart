import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

class InventoryModel {
  final int id;
  final String? barcode;
  final String name;
  final String? inventoryNumber;
  final int quantity;
  final String? description;
  final DateTime dateAdded;
  final int? employeeId;
  final int? roomId;
  final int? categoryId;
  final DateTime createdAt;

  InventoryModel({
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
      categoryId: categoryId,
      createdAt: createdAt,
    );
  }

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
      categoryId: entity.categoryId,
      createdAt: entity.createdAt,
    );
  }

  factory InventoryModel.fromJson(Map<String, dynamic> json) =>
      InventoryModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
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
      categoryId: map['categoryId'] as int?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

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
      'categoryId': categoryId,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
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
