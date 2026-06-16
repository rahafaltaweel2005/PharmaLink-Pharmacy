import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_link/features/order/presentation/createOrder/state/create_order_state.dart';

import '../../../domain/entity/order_item_entity.dart';
import '../../../domain/usecase/create_order_use_case.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  final CreateOrderUseCase createOrderUseCase;

  CreateOrderCubit({required this.createOrderUseCase})
    : super(CreateOrderInitialState());

  Future<void> createOrder({
    required List<OrderItemEntity> orderItems,
    String? notes,
  }) async {
    emit(CreateOrderLoadingState());
    try {
      final result = await createOrderUseCase.call(
        orderItems: orderItems,
        notes: notes,
      );
      emit(CreateOrderSuccessState(order: result));
    } catch (error) {
      emit(CreateOrderErrorState(error: error.toString()));
    }
  }
}
