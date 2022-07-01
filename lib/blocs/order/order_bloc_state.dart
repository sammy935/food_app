part of 'order_bloc_cubit.dart';

abstract class OrderBlocState extends Equatable {}

class OrderBlocInitial extends OrderBlocState {
  @override
  List<Object?> get props => [];
}

class GetDataInProgress extends OrderBlocState {
  @override
  List<Object?> get props => [];
}

class GetDataFailed extends OrderBlocState {
  final String message;
  GetDataFailed(this.message);
  @override
  List<Object?> get props => [message];
}

class GetDataCompleted extends OrderBlocState {
  final List<OrderModel> data;
  GetDataCompleted(this.data);

  @override
  List<Object?> get props => [data];
}

class AddToCartFailed extends OrderBlocState {
  final String message;
  AddToCartFailed(this.message);
  @override
  List<Object?> get props => [message];
}
