class FoodItemTable {
  static const String tableName = "FoodItem";

  static const String id = "id";
  static const String name = "name";
  static const String description = "fullDescription";
  static const String price = 'price';

  static const String createTable =
      "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $description	TEXT, $price	INTEGER)";
}
// (Fields to store in table: ItemID,Name,FullDescription,Price)

// CREATE TABLE CategoryImages (CImgID INTEGER PRIMARY KEY AUTOINCREMENT, ImageUrl TEXT,CategoryID      INTEGER NOT NULL,
// FOREIGN KEY (CategoryID)
// REFERENCES CategoryMasters (id) );
