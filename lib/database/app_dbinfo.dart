import 'package:samip_grubrr/database/tableModels/categoryimages_table.dart';
import 'package:samip_grubrr/database/tableModels/categorymasters_table.dart';
import 'package:samip_grubrr/database/tableModels/category_item_mappings_table.dart';
import 'package:samip_grubrr/database/tableModels/fooditem_table.dart';
import 'package:samip_grubrr/database/tableModels/food_item_images_table.dart';
import 'package:samip_grubrr/database/tableModels/screensavers_table.dart';
import 'package:samip_grubrr/model/order_model.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseInfo {
  static const String databaseName = "grubrr.db";
  static const int databaseVersion = 1;

  List<String> getTableNameList() {
    List<String> dbTableNameList = [];
    dbTableNameList.add(ScreenSaversTable.tableName);
    dbTableNameList.add(CategoryMastersTable.tableName);
    dbTableNameList.add(FoodItemTable.tableName);
    dbTableNameList.add(CategoryImagesTable.tableName);
    dbTableNameList.add(FoodItemImagesTable.tableName);
    dbTableNameList.add(CategoryItemMappingTable.tableName);
    return dbTableNameList;
  }

  // List<String> _generateDropQueryList() {
  //   List<String> dbDropList = getTableNameList();
  //   for (var i = 0; i < getTableNameList().length; i++) {
  //     String query = "DROP TABLE IF EXISTS ${getTableNameList()[i]}";
  //     dbDropList.add(query);
  //   }
  //   return dbDropList;
  // }

  List<String> _generateCreationQueryList() {
    List<String> dbQueryList = [];
    dbQueryList.add(ScreenSaversTable.createTable);
    dbQueryList.add(CategoryMastersTable.createTable);
    // dbQueryList.add(FoodItemTable.createTable);
    dbQueryList.add(CategoryImagesTable.createTable);
    // dbQueryList.add(FoodItemImagesTable.createTable);
    dbQueryList.add(CategoryItemMappingTable.createTable);
    dbQueryList.add(OrderModel.createTable);
    return dbQueryList;
  }

  Future<bool> initDb(Database theDb) async {
    // List<String> dbDropList = _generateDropQueryList();
    List<String> dbSchemaQueryList = _generateCreationQueryList();

    for (var i = 0; i < dbSchemaQueryList.length; i++) {
      // '${dbSchemaQueryList[i]} to be created'.toLog;
      theDb.execute(dbSchemaQueryList[i]);
    }
    'new tables created'.toLog;

    return true;
  }
}
