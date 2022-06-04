import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/common_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/user_model.dart';
import 'package:tyba_frotend_engineer_test/src/data/services/register_service.dart';

class RegisterServiceImpl implements RegisterService {
  RegisterServiceImpl(this._client, {required this.appName});

  static const _userCollection = 'customers';

  final _authentication = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;

  final Dio _client;
  final String appName;

  @override
  Future<UserModel> signUpEmailPassword(String email, String password) async {
    try {
      final userCredential = await _authentication
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user.toUserModel();
    } on FirebaseAuthException catch (e) {
      throw e.setFirebaseAuthError();
    }
  }

  @override
  Future<void> registerUser(UserModel user) async {
    final userReference = _database.collection(_userCollection).doc(user.uid);
    await userReference.set(user.toJson(), SetOptions(merge: true));
  }
}
