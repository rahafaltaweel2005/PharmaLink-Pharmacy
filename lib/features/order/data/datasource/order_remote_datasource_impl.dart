import 'package:pharma_link/core/constant/api_const.dart';
import 'package:pharma_link/core/network/api_client.dart';
import 'package:pharma_link/features/order/data/datasource/order_remote_datasource.dart';
import 'package:pharma_link/features/order/data/models/order_item_model.dart';
import 'package:pharma_link/features/order/data/models/order_model.dart';

class OrderRemoteDatasourceImpl extends OrderRemoteDatasource {
  @override
  Future<OrderModel> createOrder({
    String? notes,
    required List<OrderItemModel> orderItems,
  }) async {
    final response = await ApiClient.post(
      endpoint: ApiConst.createOrder,
      data: {
        'notes': notes,
        'orderItems': orderItems
            .map(
              (orderItem) =>
                  orderItem.toJson(),
            )
            .toList(),
      },
    );
    return OrderModel.fromJson(response.data);
  }

  @override
  Future<void> deleteOrder({required int orderId}) async {
    await ApiClient.delete(endpoint: ApiConst.order(orderId));
  }

  @override
  Future<OrderModel> getOrderById({required int orderId}) async {
    final response = await ApiClient.get(endpoint: ApiConst.order(orderId));
    return OrderModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await ApiClient.get(endpoint: ApiConst.pharmacyOrder);
    final data = response.data as List;
    return data
        .map((order) => OrderModel.fromJson(order as Map<String, dynamic>))
        .toList();
  }
}
