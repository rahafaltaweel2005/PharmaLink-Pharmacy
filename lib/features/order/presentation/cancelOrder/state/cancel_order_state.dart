abstract class CancelOrderState {}

class CancelOrderInitialState extends CancelOrderState {}

class CancelOrderLoadingState extends CancelOrderState {}

class CancelOrderSuccessState extends CancelOrderState {}

class CancelOrderErrorState extends CancelOrderState {
  final String error;

  CancelOrderErrorState({required this.error});
}
