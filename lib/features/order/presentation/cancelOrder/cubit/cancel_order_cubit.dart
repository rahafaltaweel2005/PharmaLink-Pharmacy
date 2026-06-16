import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/delete_order_use_case.dart';
import '../state/cancel_order_state.dart';

class CancelOrderCubit extends Cubit<CancelOrderState> {
  final DeleteOrderUseCase deleteOrderUseCase;

  CancelOrderCubit({required this.deleteOrderUseCase})
    : super(CancelOrderInitialState());

  Future<void> cancelOrder(int id) async {
    emit(CancelOrderLoadingState());
    try {
      await deleteOrderUseCase(orderId: id);
      emit(CancelOrderSuccessState());
    } catch (error) {
      emit(CancelOrderErrorState(error: error.toString()));
    }
  }
}
