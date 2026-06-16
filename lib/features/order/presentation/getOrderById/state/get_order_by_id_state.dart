import 'package:pharma_link/features/order/domain/entity/order_entity.dart';

abstract class GetOrderByIdState {}

class GetOrderByIdInitialState extends GetOrderByIdState {}

class GetOrderByIdLoadingState extends GetOrderByIdState {}

class GetOrderByIdLoadedState extends GetOrderByIdState {
  final OrderEntity order;

  GetOrderByIdLoadedState({required this.order});
}

class GetOrderByIdErrorState extends GetOrderByIdState {
  final String error;

  GetOrderByIdErrorState({required this.error});
}
