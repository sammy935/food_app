part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class LoadCategories extends CategoryEvent {
  @override
  List<Object?> get props => ['LoadCategories'];
}

class SelectedCategory extends CategoryEvent {
  const SelectedCategory(this.categoryList, this.id);
  final List<Category> categoryList;
  final int id;

  @override
  List<Object?> get props => [categoryList, id];
}

class LoadItemsByCategory extends CategoryEvent {
  const LoadItemsByCategory(this.categoryId);
  final int categoryId;

  @override
  List<Object?> get props => [categoryId];
}
