import '../../../domain/entity/inventory_entity.dart';

abstract class GetPharmacyInventoryState {}

class GetPharmacyInventoryInitialState extends GetPharmacyInventoryState {}

class GetPharmacyInventoryLoadingState extends GetPharmacyInventoryState {}

class GetPharmacyInventoryLoadedState extends GetPharmacyInventoryState {
  final List<InventoryEntity> inventory;

  GetPharmacyInventoryLoadedState({required this.inventory});
}

class GetPharmacyInventoryErrorState extends GetPharmacyInventoryState {
  final String error;

  GetPharmacyInventoryErrorState({required this.error});
}
