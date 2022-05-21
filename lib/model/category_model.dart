import 'package:equatable/equatable.dart';
import 'package:samip_grubrr/database/tableModels/categoryImagesTable.dart';
import 'package:samip_grubrr/database/tableModels/categoryMastersTable.dart';

class Category extends Equatable {
  final int id;
  final String imageLink;
  final String name;

  const Category({
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

  @override
  List<Object?> get props => [id, name, imageLink];
}
