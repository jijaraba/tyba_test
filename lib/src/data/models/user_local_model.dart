import 'package:json_annotation/json_annotation.dart';

part 'user_local_model.g.dart';

@JsonSerializable()
class UserLocalModel {
  UserLocalModel({
    this.uid,
    required this.email,
    required this.name,
    this.phoneNumber,
  });

  factory UserLocalModel.fromJson(Map<String, dynamic> json) =>
      _$UserLocalModelFromJson(json);

  final String? uid;
  final String email;
  final String name;
  final String? phoneNumber;

  Map<String, dynamic> toJson() => _$UserLocalModelToJson(this);
}
