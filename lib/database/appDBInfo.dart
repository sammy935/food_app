import 'dart:developer';

import 'package:samip_grubrr/models/foodItem.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseInfo {
  static const String databaseName = "grubrr.db";
  static const int databaseVersion = 7;

  List<String> getTableNameList() {
    List<String> dbTableNameList = [];
    dbTableNameList.add(FoodItemTable.tableName);
    return dbTableNameList;
  }

  List<String> _generateDropQueryList() {
    List<String> dbDropList = getTableNameList();
    for (var i = 0; i < getTableNameList().length; i++) {
      String query = "DROP TABLE IF EXISTS ${getTableNameList()[i]}";
      dbDropList.add(query);
    }

    return dbDropList;
  }

  List<String> _generateCreationQueryList() {
    List<String> dbSchemaQueryList = [];
    dbSchemaQueryList.add(FoodItemTable.createTable);
    log('$dbSchemaQueryList');
    return dbSchemaQueryList;
  }

  bool initDb(Database theDb) {
    List<String> dbDropList = _generateDropQueryList();
    List<String> dbSchemaQueryList = _generateCreationQueryList();

    for (var i = 0; i < dbDropList.length; i++) {
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
