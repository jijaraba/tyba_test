import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/dependencies.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/location_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';

final userLocalPod = FutureProvider<UserEntity?>(
  (ref) async => ref.watch(preferencesRepositoryPod).getUserLocal(),
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
