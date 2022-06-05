import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_login_repository.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_preferences_repository.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_user_repository.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/user/user_state.dart';

class UserViewModel extends StateNotifier<UserState> {
  UserViewModel(
      this._loginRepository,
      this._userRepository,
      this._preferencesRepository,
      ) : super(const UserState.initial());

  final ILoginRepository _loginRepository;
  final IUserRepository _userRepository;
  final IPreferencesRepository _preferencesRepository;


  Future<void> signOut() async {
    state = const UserState.loading();

    try {
      await _loginRepository.signOut();
      state = const UserState.success(action: UserAction.logout);
    } on Exception catch (e) {
      state = UserState.error(e.toString());
    }
  }
}
