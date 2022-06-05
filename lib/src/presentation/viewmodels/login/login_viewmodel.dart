import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/src/core/exceptions/data_exceptions.dart';
import 'package:tyba_frotend_engineer_test/src/core/forms/login/login_forn_state_notifier.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_login_repository.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_user_repository.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/login/login_state.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel(this._loginRepository, this._userRepository)
      : super(const LoginState.initial());

  final ILoginRepository _loginRepository;
  final IUserRepository _userRepository;

  Future<void> signInUserPassword(LoginFormState login) async {
    return _run(() async {
      final loginResult = await _loginRepository.signInUserPassword(
        login.email.value,
        login.password.value,
      );

      state = LoginState.success(
        exists: true,
        uid: loginResult.uid!,
        email: loginResult.email,
      );
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    state = const LoginState.loading();

    try {
      await action();
    } on Exception catch (e) {
      state = LoginState.error(e.toLoginErrorType(), e.toString());
    }
  }
}

extension ToLoginErrorTypeConverter on Exception {
  LoginErrorType toLoginErrorType() {
    switch (this) {
      case UserNotFoundException():
        return LoginErrorType.userNotFound;
      case WrongPasswordException():
        return LoginErrorType.wrongPassword;
      default:
        return LoginErrorType.undefined;
    }
  }
}
