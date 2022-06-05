import 'package:tyba_frotend_engineer_test/src/core/utils/model_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/data/services/user_service.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  UserRepository();

  UserService get _userService => UserService();

  @override
  Future<bool> existsUser(String uid) async => _userService.existsUser(uid);

  @override
  Stream<UserEntity> getUserData(String uid) {
    final userModelStream = _userService.getUserData(uid);
    return userModelStream.map((item) => item.toUserEntity());
  }
}
