import '../repository/order_repository.dart';

class DeleteOrderUseCase {
  final OrderRepository orderRepository;

  DeleteOrderUseCase({required this.orderRepository});

  Future<void> call({required int orderId}) {
    return orderRepository.deleteOrder(orderId: orderId);
  }
}
