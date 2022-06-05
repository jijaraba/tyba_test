import 'package:tyba_frotend_engineer_test/src/data/models/user_model.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/account_entity.dart';

abstract class LoginService {
  Stream<AccountEntity?> get verifyUserStatus;
  Future<UserModel> signInUserPassword(String email, String password);
  Future<List<void>> signOut();
}