// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      id: json['id'] as String,
      score: (json['score'] as num).toDouble(),
      poi: json['poi'] == null
          ? null
          : RestaurantInfoModel.fromJson(json['poi'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : RestaurantAddressModel.fromJson(
              json['address'] as Map<String, dynamic>),
    );
