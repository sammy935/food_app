import 'dart:developer';

import 'package:samip_grubrr/database/dbRepo.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/database/tableModels/categoryImagesTable.dart';
import 'package:samip_grubrr/database/tableModels/categoryMastersTable.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';

class CategoryOps {
  final String tableName = CategoryMastersTable.tableName;
  final String imageTableName = CategoryImagesTable.tableName;

  Future<CommonResponse> initData() async {
    try {
      AppDB.instance.getDatabase().transaction((txn) async {
        await txn.execute(
            "INSERT INTO CategoryMasters VALUES(100,'Burger','American in origin');");
        await txn.execute(
            "INSERT INTO CategoryMasters VALUES(101,'TEST CAT','SAMPLE desc');");
        await txn.execute(
            "INSERT INTO CategoryMasters VALUES(102,'PIZZAS','Italian in origin');");
        await txn.execute(
            " INSERT INTO CategoryImages(categoryImageUrl,CategoryID) VALUES('https://picsum.photos/id/1024/500',101);");
        await txn.execute(
            "INSERT INTO CategoryImages(categoryImageUrl,CategoryID) VALUES('https://picsum.photos/id/1000/500',101);");
        await txn.execute(
            "INSERT INTO CategoryImages(categoryImageUrl,CategoryID) VALUES('https://picsum.photos/id/500/500',102);");
      });

      return CommonResponse(message: 'Success', data: {'val': true});
    } catch (e) {
      log('$e is error');
      return CommonResponse(message: '$e');
    }
  }

  Future<CommonResponse> getAll() async {
    try {
      var res = await AppDB.instance
          .getDatabase()
          .rawQuery('SELECT * FROM ${CategoryMastersTable.tableName}');

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      return CommonResponse(message: '$e');
    }
  }
}
