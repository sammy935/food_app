class ScreenSaversTable {
  static const String tableName = "ScreenSaverMasters";

  static const String id = "ScreenSaverID";
  static const String imagePath = "ImagePath";

  static const String createTable =
      "CREATE TABLE IF NOT EXISTS $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $imagePath TEXT)";
}
