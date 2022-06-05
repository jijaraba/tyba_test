import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/dependencies.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/location_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';

final userLocalPod = FutureProvider<UserEntity?>(
  (ref) async => ref.watch(preferencesRepositoryPod).getUserLocal(),
);

final geolocationDataPod = FutureProvider<Position>(
  (ref) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  },
);

final restaurantDataPod =
    FutureProvider.family.autoDispose<List<RestaurantEntity>, LocationEntity>(
  (ref, data) async {
    return ref.watch(restaurantRepositoryPod).getRestaurantList(
          lng: data.lng,
          lan: data.lan,
        );
  },
);
