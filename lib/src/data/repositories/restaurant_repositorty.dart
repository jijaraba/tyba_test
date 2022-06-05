import 'package:tyba_frotend_engineer_test/src/data/services/restaurant_service.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/location_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_restaurant_repository.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/model_extensions.dart';

class RestaurantRepository implements IRestaurantRepository {
  RestaurantRepository(this._restaurantService);

  final RestaurantService _restaurantService;

  @override
  Future<List<RestaurantEntity>> getRestaurantList({
    required String lng,
    required String lan,
  }) async {
    final restaurantModel =
        await _restaurantService.getRestaurantList(lng: lng, lan: lan);
    return restaurantModel.map((item) => item.toRestaurantEntity()).toList();
  }

  @override
  Future<LocationEntity> searchCity({required String search}) async {
    final locationModel =
        await _restaurantService.searchCity(search:search);
    return locationModel;
  }
}
