import '../../domain/entity/inventory_entity.dart';
import '../../domain/repository/inventory_repository.dart';
import '../datasource/inventory_remote_datasource.dart';

class InventoryRepositoryImpl extends InventoryRepository {
  final InventoryRemoteDatasource inventoryRemoteDatasource;

  InventoryRepositoryImpl({required this.inventoryRemoteDatasource});

  @override
  Future<List<InventoryEntity>> getPharmacyInventory() async {
    final model = await inventoryRemoteDatasource.getPharmacyInventory();
    return model.map((medicine) => medicine.toEntity()).toList();
  }
}
