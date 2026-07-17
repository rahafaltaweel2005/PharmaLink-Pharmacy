import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/cart_item_entity.dart';
import '../state/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartStateInitialState());

  final List<CartItemEntity> items = [];
  double totalPrice = 0;

  void addToCart(CartItemEntity item) {
    try {
      final index = items.indexWhere(
        (element) => element.medicine.id == item.medicine.id,
      );
      if (index == -1) {
        items.add(item);
      } else {
        items[index] = items[index].copyWith(
          quantity: items[index].quantity + 1,
        );
      }
      calculateTotalPrice();
    } catch (error) {
      emit(CartStateErrorState(error: error.toString()));
    }
  }

  void removeFromCart(CartItemEntity item) {
    try {
      items.remove(item);
      calculateTotalPrice();
    } catch (error) {
      emit(CartStateErrorState(error: error.toString()));
    }
  }

  void incrementQuantity(CartItemEntity item) {
    try {
      final index = items.indexWhere(
        (element) => element.medicine.id == item.medicine.id,
      );
      if (index == -1) return;
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
      calculateTotalPrice();
    } catch (error) {
      emit(CartStateErrorState(error: error.toString()));
    }
  }

  void decrementQuantity(CartItemEntity item) {
    try {
      final index = items.indexWhere(
        (element) => element.medicine.id == item.medicine.id,
      );
      if (index == -1) return;
      if (items[index].quantity == 1) {
        items.remove(item);
      } else {
        items[index] = items[index].copyWith(
          quantity: items[index].quantity - 1,
        );
      }
      calculateTotalPrice();
    } catch (error) {
      emit(CartStateErrorState(error: error.toString()));
    }
  }

  void clearCart() {
    try {
      items.clear();
      calculateTotalPrice();
    } catch (error) {
      emit(CartStateErrorState(error: error.toString()));
    }
  }

  void calculateTotalPrice() {
    totalPrice = items.fold(0, (sum, item) => sum + item.totalPrice);
    emit(CartStateSuccessState(items: items, totalPrice: totalPrice));
  }

  void loadCartItems() {
    emit(CartStateSuccessState(items: items, totalPrice: totalPrice));
  }
}
