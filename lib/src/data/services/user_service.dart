import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/firebase_extensiones.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/user_model.dart';

class UserService {
  static const _userCollection = 'customers';

  final _database = FirebaseFirestore.instance;

  Future<bool> existsUser(String uid) async {
    final snapshot = await _database.doc('$_userCollection/$uid').get();
    return snapshot.exists;
  }

  Stream<UserModel> getUserData(String uid) {
    final userSnapshot = _database.doc('$_userCollection/$uid').snapshots();
    return userSnapshot.map((item) => UserModel.fromJson(item.toMap()));
  }

}
