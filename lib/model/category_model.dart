import 'package:samip_grubrr/database/tableModels/categoryImagesTable.dart';
import 'package:samip_grubrr/database/tableModels/categoryMastersTable.dart';

class Category {
  int id;
  String imageLink;
  String name;

  Category({
    required this.id,
    required this.imageLink,
    required this.name,
  });

  @override
  String toString() {
    return '$name $id $imageLink';
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json[CategoryMastersTable.id],
        imageLink: json[CategoryImagesTable.imageUrl],
        name: json[CategoryMastersTable.name],
      );
}
