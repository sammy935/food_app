import 'dart:developer';

import 'package:samip_grubrr/database/dbRepo.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/model/screenSaver_api_model.dart';
import 'package:samip_grubrr/database/tableModels/foodItemTable.dart';
import 'package:samip_grubrr/database/tableModels/food_item_images_table.dart';
import 'package:samip_grubrr/database/tableModels/screenSaversTable.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';

class FoodItemOps {
  final String tableName = FoodItemTable.tableName;
  final String imageTableName = FoodItemImagesTable.tableName;

  Future<CommonResponse> initData() async {
    try {
      // await Future.forEach(response.screenSaverMasters!,
      //         (ScreenSaverMaster element) async {
      //       return await AppDB.instance
      //           .getDatabase()
      //           .insert(tableName, element.toJson());
      //     });
      //
      //      AppDB.instance.getDatabase().execute('''
      //      INSERT INTO CategoryMasters VALUES(100,'Burger','American in origin');
      // INSERT INTO CategoryMasters VALUES(101,'TEST CAT','SAMPLE desc');
      // INSERT INTO CategoryMasters VALUES(102,'PIZZAS','Italian in origin');
      // INSERT INTO CategoryImages(ImageUrl,CategoryID) VALUES('https://picsum.photos/id/1024/500',101);
      //      INSERT INTO CategoryImages(ImageUrl,CategoryID) VALUES('https://picsum.photos/id/1000/500',101);
      //      INSERT INTO CategoryImages(ImageUrl,CategoryID) VALUES('https://picsum.photos/id/500/500',102);
      //      ''');

      return CommonResponse(message: 'Success', data: {'val': true});
    } catch (e) {
      log('$e is error');
      return CommonResponse(message: '$e');
    }
  }

  Future<CommonResponse> getAll(int cId) async {
    try {
//       var res = await AppDB.instance.getDatabase().rawQuery('''
//           SELECT
//     ${FoodItemTable.id},${FoodItemTable.name},${FoodItemImagesTable.imageUrl}
// FROM
//     $tableName
// INNER JOIN $imageTableName
//     ON $tableName.${FoodItemTable.id} = $imageTableName.${FoodItemImagesTable.id};
//           ''');

      var res;

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      return CommonResponse(message: '$e');
    }
  }
}
