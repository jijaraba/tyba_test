import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/account_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_login_repository.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_preferences_repository.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_user_repository.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/home/home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(
    this._loginRepository,
    this._userRepository,
    this._preferencesRepository,
  ) : super(const HomeState.initial());

  final ILoginRepository _loginRepository;
  final IUserRepository _userRepository;
  final IPreferencesRepository _preferencesRepository;

  Stream<AccountEntity?> verifyUser() => _loginRepository.verifyUserStatus;

  Stream<UserEntity> getUser(String uid) {
    try {
      state = const HomeState.success();
      return _userRepository.getUserData(uid);
    } on Exception catch (e) {
      state = HomeState.error(HomeErrorType.noUserData, e.toString());
      return _userRepository.getUserData(uid);
    }
  }

  Future<void> updateLocalData(UserEntity user) async {
    await Future.wait([
      _preferencesRepository.setUserId(user.uid),
      _preferencesRepository.setUserLocal(user),
    ]);
  }

  Future<void> restoreValues() async {
    await _preferencesRepository.setUserId(null);
    await _preferencesRepository.setUserLocal(null);
  }
}
