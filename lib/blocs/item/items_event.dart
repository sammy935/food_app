part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();
}

class LoadCategoryItems extends ItemsEvent {
  const LoadCategoryItems(this.categoryId);
  final int categoryId;

  @override
  List<Object?> get props => [categoryId];
}
