
import 'package:pharma_link/features/order/domain/entity/order_entity.dart';

abstract class CreateOrderState {}

class CreateOrderInitialState extends CreateOrderState {}

class CreateOrderLoadingState extends CreateOrderState {}

class CreateOrderSuccessState extends CreateOrderState {
  final OrderEntity order;

  CreateOrderSuccessState({required this.order});
}

class CreateOrderErrorState extends CreateOrderState {
  final String error;

  CreateOrderErrorState({required this.error});
}
