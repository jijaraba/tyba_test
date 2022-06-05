import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/user_local_model.dart';

class PreferencesService {
  PreferencesService(this._preferences);

  final SharedPreferences _preferences;

  static const _userIdKey = 'userId';
  static const _userImageKey = 'imageUrl';
  static const _userLocalKey = 'userLocal';

  String? getUserId() {
    final userId = _preferences.getString(_userIdKey);
    return (userId ?? '').isNotEmpty ? userId : null;
  }

  Future<bool> setUserId(String? id) async =>
      _preferences.setString(_userIdKey, id ?? '');

  UserLocalModel? getUserLocal() {
    final userEncoded = _preferences.getString(_userLocalKey);
    return (userEncoded ?? '').isNotEmpty
        ? UserLocalModel.fromJson(
      json.decode(userEncoded!) as Map<String, dynamic>,
    )
        : null;
  }

  Future<bool> setUserLocal(UserLocalModel? user) => user != null
      ? _preferences.setString(_userLocalKey, json.encode(user.toJson()))
      : _preferences.setString(_userLocalKey, '');

}
