import 'package:equatable/equatable.dart';
import 'package:samip_grubrr/database/tableModels/foodItemTable.dart';
import 'package:samip_grubrr/database/tableModels/food_item_images_table.dart';

class FoodItem extends Equatable {
  final int id;
  final String imageLink;
  final String name;
  final double price;

  const FoodItem({
    required this.id,
    required this.imageLink,
    required this.name,
    required this.price,
  });

  @override
  String toString() {
    return '$name $id $imageLink $price';
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
        id: json[FoodItemTable.id],
        imageLink: json[FoodItemImagesTable.imageUrl],
        name: json[FoodItemTable.name],
        price: json[FoodItemTable.price],
      );

  @override
  List<Object?> get props => [id, imageLink, name, price];
}
