// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      categoryId: json['cId'] as int,
      itemId: json['itemId'] as int,
      categoryName: json['categoryName'] as String,
      itemName: json['itemName'] as String,
      itemImageUrl: json['imageUrl'] as String,
      itemPrice: (json['price'] as num).toDouble(),
      quantity: json['qty'] as int,
      orderTotal: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'cId': instance.categoryId,
      'itemId': instance.itemId,
      'categoryName': instance.categoryName,
      'itemName': instance.itemName,
      'imageUrl': instance.itemImageUrl,
      'price': instance.itemPrice,
      'qty': instance.quantity,
      'total': instance.orderTotal,
    };
