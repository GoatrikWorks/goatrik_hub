import 'package:get_it/get_it.dart';

import '../core/network/dio_client.dart';
import '../core/network/network_info.dart';
import '../core/storage/hive_storage.dart';
import '../core/storage/secure_storage.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Registrera tjänster
  locator.registerLazySingleton<DioClient>(() => DioClient());
  locator.registerLazySingleton<SecureStorage>(() => SecureStorage());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
  await HiveStorage.init();
  // Registrera fler tjänster om det behövs
}
