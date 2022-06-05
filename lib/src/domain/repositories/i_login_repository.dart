
import 'package:tyba_frotend_engineer_test/src/domain/entities/account_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';

abstract class ILoginRepository {
  Stream<AccountEntity?> get verifyUserStatus;

  Future<UserEntity> signInUserPassword(String email, String password);
  Future<List<void>> signOut();
}
