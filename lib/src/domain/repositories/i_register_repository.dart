import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';

abstract class IRegisterRepository {
  Future<UserEntity> signUpEmailPassword(String email, String password);
  Future<void> registerUser(UserEntity user);
}
