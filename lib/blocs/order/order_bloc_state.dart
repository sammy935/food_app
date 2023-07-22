part of 'order_bloc_cubit.dart';

abstract class OrderBlocState extends Equatable {}

abstract class FailedState extends OrderBlocState {
  final String failMessage;
  FailedState(this.failMessage);
}

class OrderBlocInitial extends OrderBlocState {
  @override
  List<Object?> get props => [];
}

class GetDataInProgress extends OrderBlocState {
  @override
  List<Object?> get props => [];
}

class GetDataFailed extends FailedState {
  GetDataFailed(String message) : super(message);
  @override
  List<Object?> get props => [failMessage];
}

class GetDataCompleted extends OrderBlocState {
  final List<OrderModel> data;
  GetDataCompleted(this.data);

  @override
  List<Object?> get props => [data];
}

class AddToCartFailed extends FailedState {
  AddToCartFailed(String message) : super(message);
  @override
  List<Object?> get props => [failMessage];
}

class DeleteItemCartFailed extends FailedState {
  DeleteItemCartFailed(String message) : super(message);
  @override
  List<Object?> get props => [failMessage];
}
