import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samip_grubrr/database/appDBInfo.dart';
import 'package:samip_grubrr/utils/base_extension.dart';
import 'package:sqflite/sqflite.dart';

class AppDB {
  late Database _db;

  AppDB._privateConstructor();

  static final AppDB instance = AppDB._privateConstructor();

  Database getDatabase() {
    return _db;
  }

  Future openDB() async {
    Directory userDirectory = await getApplicationDocumentsDirectory();
    String path = join(userDirectory.path, AppDatabaseInfo.databaseName);
    'path =>>${path.toString()}'.toLog;

    await deleteDatabase(path);

    await openDatabase(path, version: AppDatabaseInfo.databaseVersion)
        .then((db) {
      _db = db;
      'db open.'.toLog;

      AppDatabaseInfo().initDb(_db);
    }).catchError((error) {
      'Error while tring to open db: $error'.toErrorLog;
    });
  }

  Future close() async => _db.close();
}
