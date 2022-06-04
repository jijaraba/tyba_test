import 'package:tyba_frotend_engineer_test/src/data/models/user_local_model.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/user_model.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';

extension ToUserEntityX on UserEntity {
  UserModel toUserModel() {
    return UserModel(
      uid: uid,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
    );
  }

  UserLocalModel toUserLocalModel() {
    return UserLocalModel(
      uid: uid,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}