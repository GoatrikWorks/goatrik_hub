import 'dart:io' show Platform;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiUrl {
    final configuredUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

    if (Platform.isAndroid) {
      // För Android-emulator
      return configuredUrl
          .replaceAll('localhost', '10.0.2.2')
          .replaceAll('127.0.0.1', '10.0.2.2');
    }

    if (Platform.isIOS) {
      if (configuredUrl.contains('localhost') ||
          configuredUrl.contains('127.0.0.1')) {
        final isSimulator = bool.fromEnvironment(
            'FLUTTER_TEST_DEVICE_IS_SIMULATOR',
            defaultValue: false);
        if (isSimulator) {
          // För iOS-simulator
          return configuredUrl;
        } else {
          // För fysisk iOS-enhet
          return configuredUrl
              .replaceAll('localhost', '192.168.175.168')
              .replaceAll('127.0.0.1', '192.168.175.168');
        }
      }
    }

    return configuredUrl;
  }

  static int get connectTimeout =>
      int.parse(dotenv.env['CONNECT_TIMEOUT'] ?? '5000');
  static int get receiveTimeout =>
      int.parse(dotenv.env['RECEIVE_TIMEOUT'] ?? '3000');
  static String get appStoreId => dotenv.env['APP_STORE_ID'] ?? '';
  static String get playStoreId => dotenv.env['PLAY_STORE_ID'] ?? '';
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';
  static bool get isStaging => environment == 'staging';
}
