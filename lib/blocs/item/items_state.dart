part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();
}

class ItemsInitial extends ItemsState {
  @override
  List<Object> get props => [];
}
