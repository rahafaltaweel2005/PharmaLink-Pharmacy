import 'package:pharma_link/features/order/domain/entity/order_item_entity.dart';

import '../models/order_model.dart';

abstract class OrderRemoteDatasource {
  Future<OrderModel> createOrder({
    String? notes,
    required List<OrderItemEntity> orderItems,
  });

  Future<OrderModel> getOrderById({required int orderId});

  Future<void> deleteOrder({required int orderId});

  Future<List<OrderModel>> getOrders();
}
