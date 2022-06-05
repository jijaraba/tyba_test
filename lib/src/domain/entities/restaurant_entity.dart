import 'package:equatable/equatable.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_address_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_info_entity.dart';

class RestaurantEntity extends Equatable {
  const RestaurantEntity({
    required this.id,
    required this.score,
    this.poi,
    this.address,
  });

  final String id;
  final double score;
  final RestaurantInfoEntity? poi;
  final RestaurantAddressEntity? address;

  @override
  List<Object?> get props => [id, score, poi, address];
}
