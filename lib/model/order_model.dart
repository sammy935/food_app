import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../database/tableModels/categoryMastersTable.dart';
import '../database/tableModels/foodItemTable.dart';
import '../database/tableModels/food_item_images_table.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  static const String tableName = "OrderTable";

  static const String categoryIdString = CategoryMastersTable.id;
  static const String itemIdString = FoodItemTable.id;
  static const String categoryNameString = CategoryMastersTable.name;
  static const String itemNameString = FoodItemTable.name;
  static const String itemImageUrlString = FoodItemImagesTable.imageUrl;
  static const String itemPriceString = FoodItemTable.price;

  static const String qty = 'qty';
  static const String total = 'total';

  static const String createTable =
      "CREATE TABLE IF NOT EXISTS $tableName ($categoryNameString TEXT,$itemNameString TEXT,$itemImageUrlString TEXT, $total	REAL, $qty	INTEGER, $itemPriceString	REAL, $itemIdString INTEGER PRIMARY KEY NOT NULL, $categoryIdString INTEGER NOT NULL, FOREIGN KEY ($itemIdString) REFERENCES ${FoodItemTable.tableName} (${FoodItemTable.id}), FOREIGN KEY ($categoryIdString) REFERENCES ${CategoryMastersTable.tableName} (${CategoryMastersTable.id}))";

  @JsonKey(name: categoryIdString)
  final int categoryId;

  @JsonKey(name: itemIdString)
  final int itemId;

  @JsonKey(name: categoryNameString)
  final String categoryName;

  @JsonKey(name: itemNameString)
  final String itemName;

  @JsonKey(name: itemImageUrlString)
  final String itemImageUrl;

  @JsonKey(name: itemPriceString)
  final double itemPrice;

  @JsonKey(name: qty)
  final int quantity;

  @JsonKey(name: total)
  final double orderTotal;

  @JsonKey(ignore: true)
  final bool? isDecrement;

  const OrderModel({
    required this.categoryId,
    this.isDecrement,
    required this.itemId,
    required this.categoryName,
    required this.itemName,
    required this.itemImageUrl,
    required this.itemPrice,
    required this.quantity,
    required this.orderTotal,
  });
  @override
  List<Object?> get props => [
        itemId,
        itemName,
        // itemImageUrl,
        itemPrice,
        quantity,
        orderTotal,
      ];
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel copyWith({double? newTotal, int? newQty, bool? isDecrease}) =>
      OrderModel(
        categoryId: categoryId,
        itemId: itemId,
        categoryName: categoryName,
        itemName: itemName,
        itemImageUrl: itemImageUrl,
        itemPrice: itemPrice,
        quantity: newQty ?? quantity,
        orderTotal: newTotal ?? orderTotal,
        isDecrement: isDecrease ?? isDecrement,
      );
}
