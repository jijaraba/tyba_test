
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';

abstract class IPreferencesRepository {
  String? getUserId();
  Future<bool> setUserId(String? id);
  UserEntity? getUserLocal();
  Future<bool> setUserLocal(UserEntity? user);
}
