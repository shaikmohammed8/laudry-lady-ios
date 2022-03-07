import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  OrderModel({
    required this.services,
    required this.price,
    required this.detergent,
    required this.fabricSoftener,
    required this.starch,
    required this.name,
    this.apartment,
    required this.phone,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.items,
    required this.status,
    required this.date,
    this.instructions,
  });

  final Map services;
  final int price;
  final String detergent;
  final String fabricSoftener;
  final String starch;
  final String name;
  @JsonKey(includeIfNull: false)
  final String? apartment;
  final String phone;
  final String address;
  final String city;
  final String postalCode;
  final List items;
  final String status;
  final String date;
  @JsonKey(includeIfNull: false)
  final String? instructions;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
// flutter pub run build_runner build --delete-conflicting-outputs