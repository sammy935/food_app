import 'dart:developer';

import 'package:samip_grubrr/tableModels/categoryImagesTable.dart';
import 'package:samip_grubrr/tableModels/categoryMastersTable.dart';
import 'package:samip_grubrr/tableModels/foodItemTable.dart';
import 'package:samip_grubrr/tableModels/food_item_images_table.dart';
import 'package:samip_grubrr/tableModels/screenSaversTable.dart';
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
    return dbTableNameList;
  }

  List<String> _generateDropQueryList() {
    List<String> dbDropList = getTableNameList();
    for (var i = 0; i < getTableNameList().length; i++) {
      String query = "DROP TABLE IF EXISTS ${getTableNameList()[i]}";
      dbDropList.add(query);
    }
    log('$dbDropList is drop');
    return dbDropList;
  }

  List<String> _generateCreationQueryList() {
    List<String> dbQueryList = [];
    dbQueryList.add(ScreenSaversTable.createTable);
    dbQueryList.add(CategoryMastersTable.createTable);
    dbQueryList.add(FoodItemTable.createTable);
    dbQueryList.add(CategoryImagesTable.createTable);
    dbQueryList.add(FoodItemImagesTable.createTable);
    log('$dbQueryList');
    return dbQueryList;
  }

  bool initDb(Database theDb) {
    List<String> dbDropList = _generateDropQueryList();
    List<String> dbSchemaQueryList = _generateCreationQueryList();

    for (var i = 0; i < dbDropList.length; i++) {
      log('${dbDropList[i]} to be dropped');
      theDb.execute(dbDropList[i]);
    }
    log('table deleted');

    for (var i = 0; i < dbSchemaQueryList.length; i++) {
      theDb.execute(dbSchemaQueryList[i]);
    }
    log('new tables created');

    return true;
  }
}
