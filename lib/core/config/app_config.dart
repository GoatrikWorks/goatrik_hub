import 'package:flutter/foundation.dart';

import 'env.dart';

class AppConfig {
  static String apiUrl = Env.apiUrl;
  static String appName = 'GoatrikHub';
  static String appVersion = '1.0.0';
  static bool isDevelopment = kDebugMode;

  static Future<void> initialize() async {}
}
