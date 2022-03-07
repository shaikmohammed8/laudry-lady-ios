// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      services: json['services'] as Map<String, dynamic>,
      price: json['price'] as int,
      detergent: json['detergent'] as String,
      fabricSoftener: json['fabricSoftener'] as String,
      starch: json['starch'] as String,
      name: json['name'] as String,
      apartment: json['apartment'] as String?,
      phone: json['phone'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      postalCode: json['postalCode'] as String,
      items: json['items'] as List<dynamic>,
      status: json['status'] as String,
      date: json['date'] as String,
      instructions: json['instructions'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) {
  final val = <String, dynamic>{
    'services': instance.services,
    'price': instance.price,
    'detergent': instance.detergent,
    'fabricSoftener': instance.fabricSoftener,
    'starch': instance.starch,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('apartment', instance.apartment);
  val['phone'] = instance.phone;
  val['address'] = instance.address;
  val['city'] = instance.city;
  val['postalCode'] = instance.postalCode;
  val['items'] = instance.items;
  val['status'] = instance.status;
  val['date'] = instance.date;
  writeNotNull('instructions', instance.instructions);
  return val;
}
