import '../../../../core/constant/api_const.dart';
import '../../../../core/network/api_client.dart';
import '../models/inventory_model.dart';
import 'inventory_remote_datasource.dart';

class InventoryRemoteDatasourceImpl extends InventoryRemoteDatasource {
  @override
  Future<List<InventoryModel>> getPharmacyInventory() async {
    final response = await ApiClient.get(endpoint: ApiConst.pharmacyInventory);
    final data = response.data as List;
    return data
        .map(
          (medicine) =>
              InventoryModel.fromJson(medicine as Map<String, dynamic>),
        )
        .toList();
  }
}
