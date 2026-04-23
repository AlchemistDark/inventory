import 'package:equatable/equatable.dart';

/// Domain entity representing an inventory item
class InventoryEntity extends Equatable {
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
}
