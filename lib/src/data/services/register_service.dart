
import 'package:tyba_frotend_engineer_test/src/data/models/user_model.dart';

abstract class RegisterService {
  Future<UserModel> signUpEmailPassword(String email, String password);
  Future<void> registerUser(UserModel user);
}
