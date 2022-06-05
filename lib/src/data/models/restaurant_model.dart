import 'package:json_annotation/json_annotation.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/restaurant_address_model.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/restaurant_info_model.dart';

part 'restaurant_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.score,
    this.poi,
    this.address,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  final String id;
  final double score;
  final RestaurantInfoModel? poi;
  final RestaurantAddressModel? address;
}
