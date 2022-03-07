import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel(
      {this.postalCode,
      this.city,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.address,
      this.apartment,
      this.email,
      this.id});
  @JsonKey(includeIfNull: false)
  final String? postalCode;
  @JsonKey(includeIfNull: false)
  @JsonKey(includeIfNull: false)
  final String? id;
  @JsonKey(includeIfNull: false)
  final String? firstName;
  @JsonKey(includeIfNull: false)
  final String? lastName;
  @JsonKey(includeIfNull: false)
  final String? phoneNumber;
  @JsonKey(includeIfNull: false)
  final String? address;
  @JsonKey(includeIfNull: false)
  final String? apartment;
  @JsonKey(includeIfNull: false)
  final String? email;
  @JsonKey(includeIfNull: false)
  final String? city;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
