import '../entity/order_entity.dart';
import '../entity/order_item_entity.dart';

abstract class OrderRepository {
  Future<OrderEntity> createOrder({
    String? notes,
    required List<OrderItemEntity> orderItems,
  });

  Future<OrderEntity> getOrderById({required int orderId});
  Future<void> deleteOrder({required int orderId});
  Future <List<OrderEntity>> getOrders();
}
