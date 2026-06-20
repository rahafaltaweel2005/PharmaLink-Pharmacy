
import '../models/inventory_model.dart';

abstract class InventoryRemoteDatasource {

  Future<List<InventoryModel>> getPharmacyInventory();
}
