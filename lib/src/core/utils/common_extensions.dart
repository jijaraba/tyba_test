import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tyba_frotend_engineer_test/src/config/localizations.dart';
import 'package:tyba_frotend_engineer_test/src/core/exceptions/data_exceptions.dart';
import 'package:tyba_frotend_engineer_test/src/data/models/user_model.dart';

extension ToBuildContextX on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this);
  ThemeData get theme => Theme.of(this);
}

extension StringX on String {

  DateTime get stringToDate => DateFormat('dd/MM/yyyy').parse(this);

  DateTime get stringToDateTime => DateFormat('dd/MM/yyyy hh:mm a').parse(this);

  bool get validateEmail => RegExp(
    r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  ).hasMatch(this);

  static const passwordRegexString =
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[*$@&[\]{}=#._\-!?+/£€%])[A-Za-z\d*$@&[\]{}=#._\-!?+/£€%]{8,}$';

  bool get validatePassword => RegExp(passwordRegexString).hasMatch(this);

  bool get validatePhone => RegExp(r'^[0-9]+$').hasMatch(this);

  bool get validateStrings =>
      RegExp(r'^(?!\s*$)[a-zA-Z-À-ÿ- ]{1,}$').hasMatch(this);

  bool get validateNumber => RegExp(r'^[0-9]+$').hasMatch(this);

  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');

    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String formatName() {
    final nameSplit = split(' ');
    return nameSplit.length <= 3 ? this : '${nameSplit[0]} ${nameSplit[2]}';
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}


extension ToAuthExceptionX on FirebaseAuthException {
  AuthGenericException setFirebaseAuthError() {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const AuthExistsProviderException();
      case 'invalid-credential':
        return const InvalidCredentialException();
      case 'user-disabled':
        return const UserDisabledException();
      case 'user-not-found':
        return const UserNotFoundException();
      case 'email-already-in-use':
        return const EmailAlreadyInUseException();
      case 'wrong-password':
        return const WrongPasswordException();
      case 'operation-not-allowed':
      default:
        return const OperationNotAllowedException();
    }
  }
}

extension ToUserX on User? {
  UserModel toUserModel() {
    final user = this ?? FirebaseAuth.instance.currentUser;
    return UserModel(
      uid: user!.uid,
      email: user.email!,
      name: user.displayName ?? '',
    );
  }
}
