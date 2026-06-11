import 'package:pharma_link/features/order/data/models/order_item_model.dart';

import '../models/order_model.dart';

abstract class OrderRemoteDatasource {
  Future<OrderModel> createOrder({
    String? notes,
    required List<OrderItemModel> orderItems,
  });

  Future<OrderModel> getOrderById({required int orderId});

  Future<void> deleteOrder({required int orderId});

  Future<List<OrderModel>> getOrders();
}
