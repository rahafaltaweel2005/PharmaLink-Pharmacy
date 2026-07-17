import '../entity/inventory_entity.dart';

abstract class InventoryRepository {
  Future<List<InventoryEntity>> getPharmacyInventory();
}
