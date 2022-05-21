part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();
}

class ItemsInitial extends ItemsState {
  @override
  List<Object> get props => [];
}

class LoadCategoryItemsInProgress extends ItemsState {
  @override
  List<Object?> get props => ['LoadCategoryItemsInProgress'];
}

class LoadCategoryItemsFailed extends ItemsState {
  const LoadCategoryItemsFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class LoadCategoryItemsCompleted extends ItemsState {
  const LoadCategoryItemsCompleted(this.itemList);
  final List<FoodItem> itemList;

  @override
  List<Object?> get props => [itemList];
}
