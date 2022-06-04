// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocalModel _$UserLocalModelFromJson(Map<String, dynamic> json) =>
    UserLocalModel(
      uid: json['uid'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$UserLocalModelToJson(UserLocalModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
    };
