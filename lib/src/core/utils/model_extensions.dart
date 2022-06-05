import 'package:tyba_frotend_engineer_test/src/data/models/restaurant_address_model.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/restaurant_info_model.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/restaurant_model.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/user_local_model.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/user_model.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_address_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_info_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';

extension ToUserModelX on UserModel {
  UserEntity toUserEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}

extension ToUserLocalModelX on UserLocalModel {
  UserEntity toUserEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}

extension ToRestaurantModelX on RestaurantModel {
  RestaurantEntity toRestaurantEntity() {
    return RestaurantEntity(
      id: id,
      score: score,
      poi: poi?.toRestaurantInfoEntity(),
      address: address?.toRestaurantAddressEntity(),
    );
  }
}

extension ToRestaurantInfoModelX on RestaurantInfoModel {
  RestaurantInfoEntity toRestaurantInfoEntity() {
    return RestaurantInfoEntity(
      name: name,
    );
  }
}

extension ToRestaurantAddressModelX on RestaurantAddressModel {
  RestaurantAddressEntity toRestaurantAddressEntity() {
    return RestaurantAddressEntity(freeformAddress: freeformAddress);
  }
}
