import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tyba_frotend_engineer_test/dependencies.dart';
import 'package:tyba_frotend_engineer_test/src/core/forms/search/search_form.dart';
import 'package:tyba_frotend_engineer_test/src/core/forms/search/search_form_state_notifier.dart';
import 'package:tyba_frotend_engineer_test/src/core/hooks/curved_animation_hook.dart';
import 'package:tyba_frotend_engineer_test/src/core/presentation/theme/theme.dart';
import 'package:tyba_frotend_engineer_test/src/core/presentation/widgets/custom_button.dart';
import 'package:tyba_frotend_engineer_test/src/core/presentation/widgets/custom_text_field.dart';
import 'package:tyba_frotend_engineer_test/src/core/presentation/widgets/error_container.dart';
import 'package:tyba_frotend_engineer_test/src/core/res/res.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/common_extensions.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/location_entity.dart';
import 'package:tyba_frotend_engineer_test/src/domain/entities/restaurant_entity.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/view/widgets/restaurant_item.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/common_viewmodel_provider.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/search/search_state.dart';

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

    ///Location
    final locationData =
        ref.watch(geolocationDataPod).whenOrNull(data: (data) => data);

    final restaurantData = ref.watch(
      restaurantDataPod(
        LocationEntity(
          lng: locationData != null
              ? locationData.longitude.toString()
              : "75.590553",
          lan: locationData != null
              ? locationData.latitude.toString()
              : "6.230833",
        ),
      ),
    );

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: RefreshIndicator(
        color: UIColors.green100,
        onRefresh: () async => ref.refresh(
          restaurantDataPod(
            LocationEntity(
              lng: locationData != null
                  ? locationData.longitude.toString()
                  : "75.590553",
              lan: locationData != null
                  ? locationData.latitude.toString()
                  : "6.230833",
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: restaurantData.when(
                  data: (data) => Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        ///Header
                        _RestaurantHeader(),
                        SizedBox(height: 30),
                        if (userData != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  userData.name,
                                  style: textNormal.copyWith(
                                    color: UIColors.black,
                                  ),
                                ),
                                CustomButton(
                                  text:
                                      context.localizations.text('logoutText'),
                                  onPressed: () => ref
                                      .read(userViewModelPod.notifier)
                                      .signOut(),
                                  borderColor: colorScheme.primary,
                                  textColor: colorScheme.primary,
                                  background: colorScheme.surface,
                                  elevation: 0,
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 30),

                        ///Restaurants
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: _RestaurantWrapper(
                            restaurants: data,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          onRetryPress: () => ref.refresh(
                            restaurantDataPod(
                              LocationEntity(
                                lng: locationData != null
                                    ? locationData.longitude.toString()
                                    : "75.590553",
                                lan: locationData != null
                                    ? locationData.latitude.toString()
                                    : "6.230833",
                              ),
                            ),
                          ),
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
    );
  }

  void _refreshUserData() {
    ref..refresh(userLocalPod);
  }

  void _redirect() => context.go('/login');
}

class _RestaurantHeader extends StatefulHookConsumerWidget {
  const _RestaurantHeader({Key? key}) : super(key: key);

  @override
  ConsumerState<_RestaurantHeader> createState() => __RestaurantHeaderState();
}

class __RestaurantHeaderState extends ConsumerState<_RestaurantHeader> {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final animation = useCurvedAnimation(
      animationController,
      curve: Curves.bounceInOut,
    );

    useMemoized(() => Future<void>(animationController.forward));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final userData = ref.watch(userLocalPod).whenOrNull(data: (data) => data);

    return Container(
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:
                    "https://mandolina.co/wp-content/uploads/2021/04/restaurante-el-cielo.png",
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(
                  Icons.restaurant,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: UIColors.darkBlue,
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: AspectRatio(
                  aspectRatio: 2.5 / 1.1,
                  child: ScaleTransition(
                    scale: animation,
                    child: ClipOval(
                      child: Image.asset(Assets.logoS),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(bottom: 10, child: _SearchWrapper())
        ],
      ),
    );
  }
}

class _SearchWrapper extends ConsumerWidget {
  const _SearchWrapper({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(
      searchViewModelPod,
          (_, SearchState state) => ref.refresh(
            restaurantDataPod(
              LocationEntity(
                lng:"19.590553",
                lan: "6.230833",
              ),
            ),
          ),
    );

    return Container(
      color: UIColors.white.withOpacity(0.9),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: _SearchText(),
          ),
          SizedBox(width: 10),
          Container(
            width: 100,
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            alignment: Alignment.center,
            child: _SubmitButton(
              padding: 0,
              onSubmit: () {
                ref.read(searchViewModelPod.notifier).searchByCity(
                  ref.read(searchNotifierPod),
                );
              }
            ),
          )
        ],
      ),
    );
  }

}

class _SubmitButton extends ConsumerWidget {
  final double padding;

  const _SubmitButton({
    Key? key,
    required this.onSubmit,
    this.padding = 100,
  }) : super(key: key);

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.theme.colorScheme;
    final searchFormState = ref.watch(searchNotifierPod);

    return CustomButton(
      text: context.localizations.text('searchButtonText').toUpperCase(),
      onPressed: searchFormState.status == FormzStatus.valid ? onSubmit : null,
      paddingHorizontal: padding,
      textColor: searchFormState.status == FormzStatus.valid
          ? UIColors.white
          : colorScheme.onSurface,
    );
  }
}

class _SearchText extends HookConsumerWidget {
  const _SearchText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = context.localizations;

    final emailText = ref.watch(
      searchNotifierPod.select((form) => form.search),
    );
    final emailTextController = useTextEditingController(text: emailText.value);

    return CustomTextField(
      textController: emailTextController,
      hint: localization.text('searchLabel'),
      requiredMessage: localization.text('searchRequiredText'),
      errorText: emailText.error == SearchValidation.invalid
          ? localization.text('searchInvalidText')
          : null,
      inputType: TextInputType.emailAddress,
      action: TextInputAction.next,
      onChange: (v) => ref.read(searchNotifierPod.notifier).changeSearch(v),
      isRequired: true,
    );
  }
}

class _RestaurantWrapper extends ConsumerWidget {
  final List<RestaurantEntity> restaurants;

  const _RestaurantWrapper({Key? key, required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = context.localizations;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      shrinkWrap: true,
      children: <Widget>[
        for (final restaurant in restaurants)
          RestaurantItem(restaurant: restaurant),
      ],
    );
  }
}
