import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samip_grubrr/database/tableOps/categoryOps.dart';
import 'package:samip_grubrr/model/category_model.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/model/food_item_model.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';
import 'package:samip_grubrr/utils/base_extension.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryOps categoryOps = CategoryOps();

  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is LoadCategories) {
        await onLoadCategories(event, emit);
      }
      if (event is SelectedCategory) {
        int index =
            event.categoryList.indexWhere((element) => event.id == element.id);
        index = index != -1 ? index : 1;
        emit.call(LoadCategoriesCompleted(
            categoryList: event.categoryList,
            pageViewIndex: index,
            selectedCategoryId: event.id));
      }
    });
  }

  Future<void> onLoadCategories(CategoryEvent event, Emitter emit) async {
    emit.call(LoadCategoriesInProgress());

    final CommonResponse res = await categoryOps.getAll();

    if (res.data != null) {
      final cList = (res.data![BaseApiConstants.val] as List)
          .map((e) => Category.fromJson(e))
          .toList();
      '$cList is cate list'.toLog;
      // int index =
      // cList.indexWhere((element) => event.id == element.id);
      // index = index != -1 ? index : 1;
      // note initially we give page view index 1
      emit.call(
        LoadCategoriesCompleted(
          categoryList: cList,
          pageViewIndex: 0,
          selectedCategoryId: cList.first.id,
        ),
      );
    } else {
      emit.call(LoadCategoriesFailed(res.message));
    }
  }
}
