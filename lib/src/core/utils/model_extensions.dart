import 'package:tyba_frotend_engineer_test/src/data/models/user_model.dart';
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