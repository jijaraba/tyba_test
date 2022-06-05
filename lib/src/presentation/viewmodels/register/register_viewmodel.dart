import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/src/core/forms/user/states/register_forn_state_notifier.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/user_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_register_repository.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/register/register_state.dart';

class RegisterViewModel extends StateNotifier<RegisterState> {
  RegisterViewModel(this._registerRepository)
      : super(const RegisterState.initial());

  final IRegisterRepository _registerRepository;

  Future<void> registerUser(
    RegisterFormState register, {
    String? uid,
    String? email,
  }) async {
    state = const RegisterState.loading();

    try {
      UserEntity? signupResult;
      if (uid == null && email == null) {
        signupResult = await _registerRepository.signUpEmailPassword(
          register.email.value,
          register.password.value,
        );
      }

      assert(
        (signupResult?.uid != null && signupResult?.email != null) ||
            (uid != null && email != null),
        'uid and email must be non-null',
      );

      if ((signupResult?.uid != null && signupResult?.email != null) ||
          (uid != null && email != null)) {
        await _registerRepository.registerUser(
          UserEntity(
            uid: signupResult?.uid ?? uid!,
            email: signupResult?.email ?? email!,
            name: register.name.value,
          ),
        );
      }
      state = const RegisterState.success();
    } on Exception catch (e) {
      state = RegisterState.error(ErrorType.userExists, e.toString());
    }
  }
}
