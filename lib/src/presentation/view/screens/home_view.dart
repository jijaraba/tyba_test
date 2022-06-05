import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/dependencies.dart';
import 'package:tyba_frotend_engineer_test/src/core/presentation/widgets/custom_button.dart';
import 'package:tyba_frotend_engineer_test/src/core/presentation/widgets/error_container.dart';
import 'package:tyba_frotend_engineer_test/src/core/res/res.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/common_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/location_entity.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/common_viewmodel_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key, this.uid, this.email}) : super(key: key);

  final String? uid;
  final String? email;

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late StreamSubscription _verifyUserSubscription;
  StreamSubscription? _userDataSubscription;

  @override
  void initState() {
    super.initState();
    final homeViewModel = ref.read(homeViewModelPod.notifier);

    _verifyUserSubscription = homeViewModel.verifyUser().listen((user) async {
      if (user == null) {
        await homeViewModel.restoreValues();
        _refreshUserData();
        _redirect();

        await _userDataSubscription?.cancel();
      } else {
        _userDataSubscription = homeViewModel.getUser(user.uid).listen(
          (user) async {
            await homeViewModel.updateLocalData(user);
            _refreshUserData();
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _verifyUserSubscription.cancel();
    _userDataSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final userData = ref.watch(userLocalPod).whenOrNull(data: (data) => data);
    final localization = context.localizations;

    final restaurantData = ref.watch(restaurantDataPod(
      LocationEntity(
        lng: "75.590553",
        lan: "6.230833",
      ),
    ));

    print(restaurantData);

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: RefreshIndicator(
        color: UIColors.green100,
        onRefresh: () async => ref.refresh(
          restaurantDataPod(
            LocationEntity(
              lng: "75.590553",
              lan: "6.230833",
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: restaurantData.when(
                    data: (data) => Text("Hello"),
                    loading: () => Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (e, s) => Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ErrorContainer(
                            text: localization.text('genericError'),
                            subtitle: localization.text('genericErrorSubtitle'),
                            onRetryPress: () => ref.refresh(restaurantDataPod(
                              LocationEntity(
                                lng: "75.590553",
                                lan: "6.230833",
                              ),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (userData != null)
                  CustomButton(
                    text: context.localizations.text('logoutText'),
                    onPressed: () =>
                        ref.read(userViewModelPod.notifier).signOut(),
                    borderColor: colorScheme.primary,
                    textColor: colorScheme.primary,
                    background: colorScheme.surface,
                    elevation: 0,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _refreshUserData() {
    ref..refresh(userLocalPod);
  }

  void _redirect() => context.go('/login');
}
