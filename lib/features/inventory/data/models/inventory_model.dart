import '../../domain/entities/inventory_entity.dart';

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
  final DateTime createdAt;

  InventoryModel({
    required this.id,
    this.barcode,
    required this.name,
    this.inventoryNumber,
    required this.quantity,
    this.description,
    required this.dateAdded,
    this.employeeId,
    this.roomId,
    required this.createdAt,
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
      createdAt: entity.createdAt,
    );
  }

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
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}
