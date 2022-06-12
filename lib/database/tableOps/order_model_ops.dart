import 'dart:developer';

import 'package:samip_grubrr/database/dbRepo.dart';
import 'package:samip_grubrr/database/tableModels/category_item_mappings_table.dart';
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
      // log('''SELECT ${CategoryItemMappingTable.itemId},${CategoryItemMappingTable.itemName},${CategoryItemMappingTable.itemImageUrl},${CategoryItemMappingTable.itemPrice} FROM $tableName WHERE ${CategoryItemMappingTable.categoryId} = $cId; will be run''');

      var res = await AppDB.instance
          .getDatabase()
          .rawQuery('''SELECT * FROM $tableName''');

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      return CommonResponse(message: '$e');
    }
  }

  Future<CommonResponse> updateQuantity(
      {required OrderModel orderModel}) async {
    try {
      var res2 = await AppDB.instance.getDatabase().query(
        tableName,
        where: '${OrderModel.itemIdString} = ?',
        whereArgs: [orderModel.itemId],
      );
      if (res2.isEmpty) {
        final OrderModel updateOrder =
            orderModel.copyWith(newQty: 1, newTotal: orderModel.itemPrice);

        final insertRes = await AppDB.instance
            .getDatabase()
            .insert(tableName, updateOrder.toJson());
        if (insertRes == 0) {
          throw 'not inserted';
        }
      } else {
        final OrderModel existingOrder = OrderModel.fromJson(res2.first);

        if ((orderModel.isDecrement ?? false) && existingOrder.quantity == 1) {
          //todo error handling for delete
          // final updateRes =
          await AppDB.instance.getDatabase().delete(
            tableName,
            where: '${OrderModel.itemIdString} = ?',
            whereArgs: [orderModel.itemId],
          );

          // '$updateRes is number of row updated'.toLog;
          //
          // if (updateRes != 1) {
          //   throw 'not proper update as more than 1 row updated';
          // }
        } else {
          final newQ = orderModel.isDecrement ?? false
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

      dynamic res = await AppDB.instance
          .getDatabase()
          .rawQuery('''SELECT * FROM $tableName''');
      res = res.map((e) => OrderModel.fromJson(e)).toList();

      'orderModel is $orderModel \n$res is res \n$res2 is res2'.toLog;

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      return CommonResponse(message: '$e');
    }
  }

  Future<void> deleteItem(int itemId) async {
    throw UnimplementedError();

    try {
      // log('''SELECT ${CategoryItemMappingTable.itemId},${CategoryItemMappingTable.itemName},${CategoryItemMappingTable.itemImageUrl},${CategoryItemMappingTable.itemPrice} FROM $tableName WHERE ${CategoryItemMappingTable.categoryId} = $cId; will be run''');

      // var res = await AppDB.instance.getDatabase().rawQuery('''SELECT * FROM $tableName''');
//       var res = await AppDB.instance.getDatabase().rawQuery('''
//           SELECT
//     ${CategoryItemMappingTable.itemId},${CategoryItemMappingTable.itemName},${CategoryItemMappingTable.itemImageUrl},${CategoryItemMappingTable.itemPrice}
// FROM
//     $tableName
// WHERE ${CategoryItemMappingTable.categoryId} = $cId;
//           ''');

      // return CommonResponse(message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      // return CommonResponse(message: '$e');
    }
  }
}
