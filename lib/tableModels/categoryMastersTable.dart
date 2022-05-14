class CategoryMastersTable {
  static const String tableName = "CategoryMasters";

  static const String id = "id";
  static const String name = "Name";
  static const String description = "Description";

  static const String createTable =
      "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $description	TEXT)";
}
