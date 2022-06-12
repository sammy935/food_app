import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samip_grubrr/database/tableOps/order_model_ops.dart';
import 'package:samip_grubrr/model/order_model.dart';

import '../../model/common_response.dart';
import '../../utils/base_api_const.dart';

part 'order_bloc_state.dart';

class OrderBlocCubit extends Cubit<OrderBlocState> {
  OrderModelOps orderModelOps = OrderModelOps();
  OrderBlocCubit() : super(OrderBlocInitial());

  Future<void> getData() async {
    emit(GetDataInProgress());
    try {
      final CommonResponse getAllData = await orderModelOps.getAllOrderItems();
      if (getAllData.data != null) {
        List<OrderModel> list = List<OrderModel>.from(getAllData
            .data![BaseApiConstants.val]
            .map((x) => OrderModel.fromJson(x)));
        emit(GetDataCompleted(list));
      } else {
        emit(GetDataFailed(getAllData.message));
      }
    } catch (e) {
      emit(GetDataFailed(e.toString()));
    }
  }
}
