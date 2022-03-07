import 'package:json_annotation/json_annotation.dart';
part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  ItemModel(
      {required this.title,
      required this.price,
      required this.category,
      required this.imagePath});

  final String title;
  final int price;
  final String category;
  final String imagePath;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
