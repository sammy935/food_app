import 'package:samip_grubrr/tableModels/categoryMastersTable.dart';

class CategoryImagesTable {
  static const String tableName = "CategoryImages";

  static const String id = "CImgID";
  static const String categoryId = "categoryId";
  static const String imageUrl = "imageUrl";

  static const String createTable =
      "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $imageUrl TEXT, $categoryId INTEGER NOT NULL, FOREIGN KEY ($categoryId) REFERENCES ${CategoryMastersTable.tableName} (${CategoryMastersTable.id}) ) ";
}
