import 'package:tyba_frotend_engineer_test/src/domain/entities/location_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_entity.dart';

abstract class IRestaurantRepository {
  Future<List<RestaurantEntity>> getRestaurantList({
    required String lng,
    required String lan,
  });

  Future<LocationEntity> searchCity({
    required String search,
  });
}
