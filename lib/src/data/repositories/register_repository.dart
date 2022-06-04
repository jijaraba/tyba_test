import 'package:tyba_frotend_engineer_test/src/core/exceptions/data_exceptions.dart';
import 'package:tyba_frotend_engineer_test/src/core/exceptions/domain_exceptions.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/entity_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/model_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/data/services/register_service.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_register_repository.dart';

class RegisterRepository implements IRegisterRepository {
  RegisterRepository(this._registerService);

  final RegisterService _registerService;

  @override
  Future<UserEntity> signUpEmailPassword(String email, String password) async {
    try {
      final userModel = await _registerService.signUpEmailPassword(
        email,
        password,
      );

      return userModel.toUserEntity();
    } catch (e) {
      if (e is EmailAlreadyInUseException) {
        throw const EmailAlreadyUsedException();
      } else {
        throw UnexpectedSignUpException(e.toString());
      }
    }
  }

  @override
  Future<void> registerUser(UserEntity user) async =>
      _registerService.registerUser(user.toUserModel());

}
