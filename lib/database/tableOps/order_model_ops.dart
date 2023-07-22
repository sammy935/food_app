import 'package:samip_grubrr/database/db_repo.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/model/order_model.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';
import 'package:samip_grubrr/utils/base_extension.dart';

class OrderModelOps {
  final String tableName = OrderModel.tableName;

  Future<void> initData() async {
    throw UnimplementedError();

    /// may need to get data from api and load
  }

  Future<CommonResponse> getAllOrderItems() async {
    try {
      var res = (await AppDB.instance
              .getDatabase()
              .rawQuery('''SELECT * FROM $tableName'''))
          .map((e) => OrderModel.fromJson(e))
          .toList();

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      e.toString().toErrorLog;
      return CommonResponse(message: '$e');
    }
  }

  Future<CommonResponse> updateQuantity(
      {required OrderModel orderModel}) async {
    try {
      List currentOrder = await AppDB.instance.getDatabase().query(
        tableName,
        where: '${OrderModel.itemIdString} = ?',
        whereArgs: [orderModel.itemId],
      );
      if (currentOrder.isEmpty) {
        /// if doesn't exist, add it
        final OrderModel updateOrder =
            orderModel.copyWith(newQty: 1, newTotal: orderModel.itemPrice);

        final int insertRes = await AppDB.instance
            .getDatabase()
            .insert(tableName, updateOrder.toJson());
        if (insertRes == 0) {
          throw 'not inserted';
        }
      } else {
        /// if exist, check quantity
        final OrderModel existingOrder =
            OrderModel.fromJson(currentOrder.first);

        if ((orderModel.isDecrement ?? false) && existingOrder.quantity == 1) {
          /// if decrement and quantity 1 then delete it
          await deleteItem(orderModel: existingOrder);
        } else {
          /// quantity greater than 1 then update it
          final int newQ = orderModel.isDecrement ?? false
              ? existingOrder.quantity - 1
              : existingOrder.quantity + 1;
          final OrderModel updateOrder = orderModel.copyWith(
            newQty: newQ,
            newTotal: orderModel.itemPrice * newQ,
          );
          final updateRes = await AppDB.instance.getDatabase().update(
            tableName,
            updateOrder.toJson(),
            where: '${OrderModel.itemIdString} = ?',
            whereArgs: [orderModel.itemId],
          );

          '$updateRes is number of row updated'.toLog;

          if (updateRes != 1) {
            throw 'not proper update as more than 1 row updated';
          }
        }
      }

      List res = (await AppDB.instance
              .getDatabase()
              .rawQuery('''SELECT * FROM $tableName'''))
          .map((e) => OrderModel.fromJson(e))
          .toList();

      'order is $orderModel \n$res are all orders \n$currentOrder is currentOrder from database'
          .toLog;

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      e.toString().toErrorLog;
      return CommonResponse(message: '$e');
    }
  }

  Future<CommonResponse> deleteItem({required OrderModel orderModel}) async {
    try {
      List currentOrder = await AppDB.instance.getDatabase().query(
        tableName,
        where: '${OrderModel.itemIdString} = ?',
        whereArgs: [orderModel.itemId],
      );
      bool isOrderAbsent = currentOrder.isEmpty;
      if (isOrderAbsent) {
        throw 'Order not present';
      } else {
        final int delRes = await AppDB.instance.getDatabase().delete(
          tableName,
          where: '${OrderModel.itemIdString} = ?',
          whereArgs: [orderModel.itemId],
        );

        if (delRes == 0) {
          throw 'Not deleted';
        }

        List res = (await AppDB.instance
                .getDatabase()
                .rawQuery('''SELECT * FROM $tableName'''))
            .map((e) => OrderModel.fromJson(e))
            .toList();

        'orderModel is $orderModel \n$res is res'.toLog;

        return CommonResponse(
            message: 'Success', data: {BaseApiConstants.val: res});
      }
    } catch (e, stackTree) {
      '${e.toString()}\n$stackTree '.toErrorLog;
      return CommonResponse(message: '$e');
    }
  }
}
