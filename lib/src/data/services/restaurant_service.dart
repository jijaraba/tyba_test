import 'package:dio/dio.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/restaurant_model.dart';

abstract class RestaurantService {
  Future<List<RestaurantModel>> getRestaurantList({
    required String lng,
    required String lan,
  });
}

class RestaurantServiceImpl implements RestaurantService {
  RestaurantServiceImpl(this._client, this._apiKey);

  final Dio _client;
  final String _apiKey;

  @override
  Future<List<RestaurantModel>> getRestaurantList({
    required String lng,
    required String lan,
  }) async {
    print(_apiKey);

    try {
      final response = await _client.get(
        '?lat=${lan}&lon=${lng}&view=Unified&relatedPois=off&key=${_apiKey}',
      );
      if (response.statusCode == 200) {
        print("XXXXXX");
        print(RestaurantModel.fromJson((response.data['results'] as List)[0]));
        print("XXXXXX");
        return (response.data['results'] as List)
            .map((x) => RestaurantModel.fromJson(x))
            .toList();
      }
      return [];
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
