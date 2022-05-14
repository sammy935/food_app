class ScreenSaversTable {
  static const String tableName = "ScreenSaverMasters";

  static const String id = "ScreenSaverID";
  static const String imagePath = "ImagePath";

  static const String createTable =
      "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $imagePath TEXT)";
}
