import 'dart:developer';
import 'dart:io';
import 'package:samip_grubrr/database/appDBInfo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
    log('path =>>${path.toString()}');

    await deleteDatabase(path);

    await openDatabase(path, version: AppDatabaseInfo.databaseVersion)
        .then((db) {
      _db = db;
      log('db open.');

      AppDatabaseInfo().initDb(_db);
    }).catchError((error) {
      log('Error while tring to open db: $error');
    });
  }

  Future close() async => _db.close();
}
