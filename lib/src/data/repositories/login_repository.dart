import 'package:tyba_frotend_engineer_test/src/core/utils/model_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/data/services/login_service.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/account_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_login_repository.dart';

class LoginRepository implements ILoginRepository {
  LoginRepository(this._loginService);

  final LoginService _loginService;

  @override
  Stream<AccountEntity?> get verifyUserStatus => _loginService.verifyUserStatus;

  @override
  Future<UserEntity> signInUserPassword(String email, String password) async {
    final userModel = await _loginService.signInUserPassword(email, password);
    return userModel.toUserEntity();
  }

  @override
  Future<List<void>> signOut() => _loginService.signOut();
}
