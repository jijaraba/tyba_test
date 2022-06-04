import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/src/core/forms/user/generic_user_form.dart';

class RegisterFormState with FormzMixin {
  RegisterFormState({
    this.email = const EmailForm.pure(),
    this.name = const NameForm.pure(),
    this.password = const PasswordForm.pure(),
    this.phone = const PhoneForm.pure(),
  });

  final EmailForm email;
  final NameForm name;
  final PasswordForm password;
  final PhoneForm phone;

  RegisterFormState copyWith({
    EmailForm? email,
    NameForm? name,
    PasswordForm? password,
    PhoneForm? phone,
  }) =>
      RegisterFormState(
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        phone: phone ?? this.phone,
      );

  @override
  List<FormzInput> get inputs => [
    email,
    name,
    password,
    phone,
  ];
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  void changeEmail(String value) {
    state = state.copyWith(email: EmailForm.dirty(value));
  }

  void changeName(String value) {
    state = state.copyWith(name: NameForm.dirty(value));
  }

  void changePassword(String value) {
    state = state.copyWith(password: PasswordForm.dirty(value));
  }


  void changePhone(String value) {
    state = state.copyWith(phone: PhoneForm.dirty(value));
  }

}

final registerNotifierPod =
StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
      (_) => RegisterFormNotifier(),
);
