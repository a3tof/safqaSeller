import 'dart:math';
import 'package:get_it/get_it.dart';
import 'package:safqaseller/core/network/dio_client.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/features/auth/model/repositories/auth_repository.dart';
import 'package:safqaseller/features/auth/view_model/confirm_email/confirm_email_view_model.dart';
import 'package:safqaseller/features/auth/view_model/login/login_view_model.dart';
import 'package:safqaseller/features/auth/view_model/logout/logout_view_model.dart';
import 'package:safqaseller/features/auth/view_model/register/register_view_model.dart';
import 'package:safqaseller/features/forgot_password/model/repositories/forgot_password_repository.dart';
import 'package:safqaseller/features/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // 1. External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // 2. Core — storage first, then network (DioHelper depends on CacheHelper)
  getIt.registerLazySingleton(() => CacheHelper(sharedPreferences: getIt()));

  // Ensure a stable DeviceId is persisted on first launch
  final cacheHelper = getIt<CacheHelper>();
  if (cacheHelper.getData(key: CacheKeys.deviceId) == null) {
    final deviceId = _generateDeviceId();
    await cacheHelper.saveData(key: CacheKeys.deviceId, value: deviceId);
  }

  getIt.registerLazySingleton(() => DioHelper(cacheHelper: getIt()));

  // 3. Repositories
  getIt.registerLazySingleton(
    () => AuthRepository(dioHelper: getIt(), cacheHelper: getIt()),
  );
  getIt.registerLazySingleton(
    () => ForgotPasswordRepository(dioHelper: getIt()),
  );

  // 4. ViewModels (factory = new instance per registration)
  getIt.registerFactory(() => RegisterViewModel(getIt()));
  getIt.registerFactory(() => LoginViewModel(getIt()));
  getIt.registerFactory(() => ConfirmEmailViewModel(getIt()));
  getIt.registerFactory(() => ForgotPasswordViewModel(getIt()));
  getIt.registerFactory(() => LogoutViewModel(getIt()));
}

/// Generates a cryptographically random 32-byte hex string as a unique device ID.
String _generateDeviceId() {
  final random = Random.secure();
  return List.generate(
    32,
    (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join();
}
