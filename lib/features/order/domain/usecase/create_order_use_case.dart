import '../entity/order_entity.dart';
import '../entity/order_item_entity.dart';
import '../repository/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository orderRepository;

  CreateOrderUseCase({required this.orderRepository});

  Future<OrderEntity> call({
    String? notes,
    required List<OrderItemEntity> orderItems,
  }) {
    return orderRepository.createOrder(orderItems: orderItems, notes: notes);
  }
}
