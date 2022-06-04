import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @JsonKey(name: 'id', toJson: _toNull, includeIfNull: false)
  final String? uid;
  final String email;
  final String name;
  final String? phoneNumber;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // Static methods
  static dynamic _toNull(String? val) => null;

}
