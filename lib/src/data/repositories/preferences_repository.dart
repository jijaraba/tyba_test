import 'package:tyba_frotend_engineer_test/src/data/services/preferences_service.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_preferences_repository.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/model_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/entity_extensions.dart';

class PreferencesRepository implements IPreferencesRepository {
  PreferencesRepository(this._preferenceService);

  final PreferencesService _preferenceService;

  @override
  String? getUserId() => _preferenceService.getUserId();

  @override
  Future<bool> setUserId(String? id) => _preferenceService.setUserId(id);

  @override
  UserEntity? getUserLocal() =>
      _preferenceService.getUserLocal()?.toUserEntity();

  @override
  Future<bool> setUserLocal(UserEntity? user) =>
      _preferenceService.setUserLocal(user?.toUserLocalModel());
}
