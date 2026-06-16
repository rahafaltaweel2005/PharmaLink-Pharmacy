import '../../domain/entity/cart_item_entity.dart';

abstract class CartState {}

class CartStateInitialState extends CartState {}

class CartStateLoadingState extends CartState {}

class CartStateSuccessState extends CartState {
  final List<CartItemEntity> items;
  final double totalPrice;


  CartStateSuccessState({required this.items, required this.totalPrice});
}

class CartStateErrorState extends CartState {
  final String error;

  CartStateErrorState({required this.error});
}
