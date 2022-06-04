import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tyba_frotend_engineer_test/src/config/app_config.dart';
import 'package:tyba_frotend_engineer_test/src/core/interceptors/logging_interceptor.dart';
import 'package:tyba_frotend_engineer_test/src/data/repositories/register_repository.dart';
import 'package:tyba_frotend_engineer_test/src/data/services/register_service.dart';
import 'package:tyba_frotend_engineer_test/src/data/services/register_service_impl.dart';
import 'package:tyba_frotend_engineer_test/src/domain/repositories/i_register_repository.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/register/register_state.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/viewmodels/register/register_viewmodel.dart';

//region Data source layer
final dioClientPod = Provider<Dio>(
  (ref) {
    return Dio(
      BaseOptions(
        baseUrl: ref.watch(appConfigPod).serverBaseUrl,
        connectTimeout: 15000,
      ),
    )..interceptors.add(LoggingInterceptor());
  },
  dependencies: [appConfigPod],
);

final preferencesPod = FutureProvider<SharedPreferences>(
  (_) => SharedPreferences.getInstance(),
);

final registerServicePod = Provider<RegisterService>(
      (ref) => RegisterServiceImpl(
    ref.watch(dioClientPod),
    appName: ref.watch(appConfigPod).appName,
  ),
  dependencies: [dioClientPod, appConfigPod],
);

//endregion

//register provider layer
final registerRepositoryPod = Provider<IRegisterRepository>(
      (ref) => RegisterRepository(ref.watch(registerServicePod)),
  dependencies: [registerServicePod],
);
//endregion

//region viewmodel layer
final registerViewModelPod =
StateNotifierProvider<RegisterViewModel, RegisterState>(
      (ref) => RegisterViewModel(
    ref.watch(registerRepositoryPod),
  ),
  dependencies: [registerRepositoryPod],
);

//endregion

//region App Config
final appConfigPod = Provider<AppConfig>(
  (_) => throw UnimplementedError('appConfigPod must be overridden'),
);
//endregion
