class FoodItemTable {
  static const String tableName = "FoodItem";

  static const String id = "itemId";
  static const String name = "itemName";
  static const String description = "fullDescription";
  static const String price = 'price';

  static const String createTable =
      "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $description	TEXT, $price	INTEGER)";
}
