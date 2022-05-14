import 'package:samip_grubrr/database/tableModels/categoryImagesTable.dart';
import 'package:samip_grubrr/database/tableModels/categoryMastersTable.dart';
import 'package:samip_grubrr/database/tableModels/foodItemTable.dart';
import 'package:samip_grubrr/database/tableModels/food_item_images_table.dart';

class CategoryItemMappingTable {
  static const String tableName = "CategoryItemMappingTable";

  static const String categoryId = CategoryMastersTable.id;
  static const String categoryImageUrl = CategoryImagesTable.imageUrl;
  static const String categoryName = CategoryMastersTable.name;
  static const String categoryDesc = CategoryMastersTable.description;
  static const String itemId = FoodItemTable.id;
  static const String itemName = FoodItemTable.name;
  static const String itemDesc = FoodItemTable.description;
  static const String itemPrice = FoodItemTable.price;
  static const String itemImageUrl = FoodItemImagesTable.imageUrl;

  static const String createTable =
      '''CREATE TABLE $tableName ($categoryId INTEGER NOT NULL,$itemId INTEGER NOT NULL, $categoryImageUrl TEXT, $itemImageUrl TEXT, $categoryName TEXT, $categoryDesc TEXT,$itemName TEXT,$itemDesc TEXT, $itemPrice INTEGER,PRIMARY KEY ($itemId, $categoryId),FOREIGN KEY ($categoryId) REFERENCES ${CategoryMastersTable.tableName} (${CategoryMastersTable.id}), FOREIGN KEY ($itemId) REFERENCES ${FoodItemTable.tableName} (${FoodItemTable.id}))''';
}
