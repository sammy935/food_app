class CategoryMastersTable {
  static const String tableName = "CategoryMasters";

  static const String id = "cId";
  static const String name = "categoryName";
  static const String description = "Description";

  static const String createTable =
      "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $name TEXT, $description	TEXT)";
}
