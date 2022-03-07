// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      title: json['title'] as String,
      price: json['price'] as int,
      category: json['category'] as String,
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'title': instance.title,
      'price': instance.price,
      'category': instance.category,
      'imagePath': instance.imagePath,
    };
