import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/dependencies.dart';
import 'package:tyba_frotend_engineer_test/src/core/forms/user/generic_user_form.dart';
import 'package:tyba_frotend_engineer_test/src/core/forms/user/states/register_forn_state_notifier.dart';
import 'package:tyba_frotend_engineer_test/src/core/presentation/widgets/custom_button.dart';
import 'package:tyba_frotend_engineer_test/src/core/presentation/widgets/custom_text_field.dart';
import 'package:tyba_frotend_engineer_test/src/core/res/res.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/common_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/view/widgets/custom_loading.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/register/register_state.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key, this.uid, this.email}) : super(key: key);

  final String? uid;
  final String? email;

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: colorScheme.background,
          body: Center(
            child: Container(
              child: Text("Home"),
            ),
          ),
        ),
      ],
    );
  }
}
