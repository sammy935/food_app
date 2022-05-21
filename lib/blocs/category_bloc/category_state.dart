part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class LoadCategoriesInProgress extends CategoryState {
  @override
  List<Object?> get props => [];
}

class LoadCategoriesFailed extends CategoryState {
  const LoadCategoriesFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class LoadCategoriesCompleted extends CategoryState {
  const LoadCategoriesCompleted({
    required this.categoryList,
    required this.pageViewIndex,
    required this.selectedCategoryId,
  });
  final List<Category> categoryList;
  final int pageViewIndex;
  final int selectedCategoryId;

  @override
  List<Object?> get props => [categoryList, pageViewIndex, selectedCategoryId];
}

class LoadItemsByCategoryInProgress extends CategoryState {
  @override
  List<Object?> get props => [];
}

class LoadItemsByCategoryFailed extends CategoryState {
  const LoadItemsByCategoryFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class LoadItemsByCategoryCompleted extends CategoryState {
  const LoadItemsByCategoryCompleted(this.itemList);
  final List<FoodItem> itemList;

  @override
  List<Object?> get props => [itemList];
}
