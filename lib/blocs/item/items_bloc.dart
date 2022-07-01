import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samip_grubrr/database/tableOps/category_item_mapping_ops.dart';
import 'package:samip_grubrr/database/tableOps/order_model_ops.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/model/food_item_model.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final CategoryItemMapOps categoryItemMapOps = CategoryItemMapOps();
  final OrderModelOps orderModelOps = OrderModelOps();

  ItemsBloc() : super(ItemsInitial()) {
    on<ItemsEvent>((event, emit) async {
      if (event is LoadCategoryItems) {
        await onLoadCategoryItems(event, emit);
      }
    });
  }

  Future<void> onLoadCategoryItems(
    LoadCategoryItems event,
    Emitter emit,
  ) async {
    emit.call(LoadCategoryItemsInProgress());

    final CommonResponse response =
        await categoryItemMapOps.getAllFoodItems(event.categoryId);
    ////

    if (response.data != null) {
      final itemList = (response.data![BaseApiConstants.val] as List)
          .map((e) => FoodItem.fromJson(e))
          .toList();
      // '$itemList is item list'.toLog;
      emit.call(LoadCategoryItemsCompleted(itemList));
    } else {
      emit.call(LoadCategoryItemsFailed(response.message));
    }
  }
}
