import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => CacheHelper(sharedPreferences: getIt()));

  final cacheHelper = getIt<CacheHelper>();
  if (cacheHelper.getData(key: CacheKeys.deviceId) == null) {
    await cacheHelper.saveData(
      key: CacheKeys.deviceId,
      value: _generateDeviceId(),
    );
  }
}

String _generateDeviceId() {
  final random = Random.secure();
  return List.generate(
    32,
    (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join();
}
