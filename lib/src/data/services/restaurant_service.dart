import 'package:dio/dio.dart';
import 'package:tyba_frotend_engineer_test/src/core/interceptors/logging_interceptor.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/restaurant_model.dart';

import '../../domain/entities/location_entity.dart';

abstract class RestaurantService {
  Future<List<RestaurantModel>> getRestaurantList({
    required String lng,
    required String lan,
  });

  Future<LocationEntity> searchCity({
    required String search,
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
    try {
      final response = await _client.get(
        '?lat=${lan}&lon=${lng}&view=Unified&relatedPois=off&key=${_apiKey}',
      );
      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((x) => RestaurantModel.fromJson(x))
            .toList();
      }
      return [];
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<LocationEntity> searchCity({required String search}) async {
    final Dio _dio = Dio(BaseOptions(
        baseUrl: 'https://api.opencagedata.com/geocode/v1/',
        connectTimeout: 15000))
      ..interceptors.add(LoggingInterceptor());

    try {
      final response = await _dio.get(
        '/json/?q=${search}&key=f88d7c60ec6646bda6bc1320f5f710b5',
      );
      if (response.statusCode == 200) {
        return LocationEntity(
          lng: response.data['results'][0]['geometry']['lng'].toString(),
          lan: response.data['results'][0]['geometry']['lat'].toString(),
        );
      }
      return LocationEntity(lng: "75.590553", lan: "6.230833");
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
