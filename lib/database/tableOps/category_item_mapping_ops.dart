import 'dart:developer';

import 'package:samip_grubrr/database/db_repo.dart';
import 'package:samip_grubrr/database/tableModels/category_item_mappings_table.dart';
import 'package:samip_grubrr/model/common_response.dart';
import 'package:samip_grubrr/utils/base_api_const.dart';

class CategoryItemMapOps {
  final String tableName = CategoryItemMappingTable.tableName;

  Future<CommonResponse> initData() async {
    try {
      await Future.wait([
        AppDB.instance.getDatabase().execute('''      
      INSERT INTO CategoryItemMappingTable VALUES (100,200,'https://picsum.photos/id/1024/500','https://picsum.photos/id/24/500','BURGER','AMERICAN in nature','McAloo Tikki', 'type of burger', 150);
      '''),
        AppDB.instance.getDatabase().execute('''      
      INSERT INTO CategoryItemMappingTable VALUES (102,201,'https://picsum.photos/id/1025/500','https://picsum.photos/id/25/500','Pizza','AMERICAN in nature','Itallina', 'type of pizza', 1250);
      '''),
        AppDB.instance.getDatabase().execute('''      
      INSERT INTO CategoryItemMappingTable VALUES (102,202,'https://picsum.photos/id/1025/500','https://picsum.photos/id/28/500','Pizza','AMERICAN in nature','McAloo Pizza 2', 'type of pizza', 550);
      '''),
        AppDB.instance.getDatabase().execute('''      
        INSERT INTO CategoryItemMappingTable VALUES (100,203,'https://picsum.photos/id/1024/500','https://picsum.photos/id/26/500','BURGER','AMERICAN in nature','McAloo MEXICAN Tikki', 'type of burger', 350);
      ''')
      ]);

      return CommonResponse(message: 'Success', data: {'val': true});
    } catch (e) {
      log('$e is error');
      return CommonResponse(message: '$e');
    }
  }

  Future<CommonResponse> getAllFoodItems(int cId) async {
    try {
      log('''SELECT ${CategoryItemMappingTable.itemId},${CategoryItemMappingTable.itemName},${CategoryItemMappingTable.itemImageUrl},${CategoryItemMappingTable.itemPrice} FROM $tableName WHERE ${CategoryItemMappingTable.categoryId} = $cId; will be run''');

      var res = await AppDB.instance.getDatabase().rawQuery('''
          SELECT
    ${CategoryItemMappingTable.itemId},${CategoryItemMappingTable.itemName},${CategoryItemMappingTable.itemImageUrl},${CategoryItemMappingTable.itemPrice}
FROM
    $tableName
WHERE ${CategoryItemMappingTable.categoryId} = $cId;
          ''');

      await AppDB.instance.getDatabase().rawQuery('''
          SELECT * FROM ${CategoryItemMappingTable.tableName}
          ''');

      return CommonResponse(
          message: 'Success', data: {BaseApiConstants.val: res});
    } catch (e) {
      log(e.toString());
      return CommonResponse(message: '$e');
    }
  }
}
