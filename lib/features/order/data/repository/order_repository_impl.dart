import 'package:pharma_link/features/order/domain/entity/order_entity.dart';
import 'package:pharma_link/features/order/domain/entity/order_item_entity.dart';
import '../../domain/repository/order_repository.dart';
import '../datasource/order_remote_datasource.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDatasource orderRemoteDatasource;

  OrderRepositoryImpl({required this.orderRemoteDatasource});

  @override
  Future<OrderEntity> createOrder({
    String? notes,
    required List<OrderItemEntity> orderItems,
  }) async {
    final model = await orderRemoteDatasource.createOrder(
      notes: notes,
      orderItems: orderItems.toList(),
    );
    return model.toEntity();
  }

  @override
  Future<void> deleteOrder({required int orderId}) async {
    await orderRemoteDatasource.deleteOrder(orderId: orderId);
  }

  @override
  Future<OrderEntity> getOrderById({required int orderId}) async {
    final model = await orderRemoteDatasource.getOrderById(orderId: orderId);
    return model.toEntity();
  }

  @override
  Future<List<OrderEntity>> getOrders() async {
    final model = await orderRemoteDatasource.getOrders();
    return model.map((order) => order.toEntity()).toList();
  }
}
