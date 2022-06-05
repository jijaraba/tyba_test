import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/common_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/user_model.dart';
import 'package:tyba_frotend_engineer_test/src/data/services/login_service.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/account_entity.dart';

class LoginServiceImpl implements LoginService {
  final _authentication = FirebaseAuth.instance;

  @override
  Stream<AccountEntity?> get verifyUserStatus =>
      _authentication.authStateChanges().map((user) => user?.toAccountEntity());

  @override
  Future<UserModel> signInUserPassword(String email, String password) async {
    try {
      final credential = await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user.toUserModel();
    } on FirebaseAuthException catch (e) {
      throw e.setFirebaseAuthError();
    }
  }

  @override
  Future<List<void>> signOut() async => Future.wait([
    _authentication.signOut(),
  ]);
}

extension ToAccountEntityConverter on User {
  AccountEntity toAccountEntity() {
    return AccountEntity(
      uid: uid,
      displayName: displayName,
    );
  }
}
