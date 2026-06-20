import '../entity/inventory_entity.dart';
import '../repository/inventory_repository.dart';

class GetPharmacyInventoryUseCase {
  final InventoryRepository inventoryRepository;

  GetPharmacyInventoryUseCase({required this.inventoryRepository});

  Future<List<InventoryEntity>> call() {
    return inventoryRepository.getPharmacyInventory();
  }
}
