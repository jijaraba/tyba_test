// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['id'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', UserModel._toNull(instance.uid));
  val['email'] = instance.email;
  val['name'] = instance.name;
  val['phone_number'] = instance.phoneNumber;
  return val;
}
