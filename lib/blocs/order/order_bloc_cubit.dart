import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samip_grubrr/database/tableOps/order_model_ops.dart';
import 'package:samip_grubrr/model/order_model.dart';
import 'package:samip_grubrr/utils/base_extension.dart';

import '../../model/common_response.dart';
import '../../utils/base_api_const.dart';

part 'order_bloc_state.dart';

class OrderBlocCubit extends Cubit<OrderBlocState> {
  OrderModelOps orderModelOps = OrderModelOps();
  OrderBlocCubit() : super(OrderBlocInitial());

  Future<void> getData() async {
    emit(GetDataInProgress());

    final CommonResponse getAllData = await orderModelOps.getAllOrderItems();
    if (getAllData.data != null) {
      emit(GetDataCompleted(getAllData.data![BaseApiConstants.val]));
    } else {
      emit(GetDataFailed(getAllData.message));
    }
  }

  Future<void> addToCart(OrderModel order, {bool isRefresh = false}) async {
    final CommonResponse response =
        await orderModelOps.updateQuantity(orderModel: order);
    if (response.data != null && isRefresh) {
      emit(GetDataCompleted(response.data![BaseApiConstants.val]));
    } else {
      emit(AddToCartFailed(response.message));
    }
  }

  Future<void> deleteOrderItem(OrderModel order) async {
    final CommonResponse getAllData =
        await orderModelOps.deleteItem(orderModel: order);
    if (getAllData.data != null) {
      emit(GetDataCompleted(getAllData.data![BaseApiConstants.val]));
    } else {
      emit(GetDataFailed(getAllData.message));
    }
  }
}
