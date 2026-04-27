import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for searching inventory by barcode
class SearchInventoryByBarcodeUseCase {
  final InventoryRepository repository;

  SearchInventoryByBarcodeUseCase(this.repository);

  Future<InventoryEntity?> call(String barcode) async {
    if (barcode.trim().isEmpty) {
      return null;
    }
    
    return await repository.getInventoryByBarcode(barcode.trim());
  }
}
