import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../storage/secure_storage.dart';
import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final SecureStorage _secureStorage = SecureStorage();

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    _secureStorage.write(key: Constants.themeKey, value: _themeMode.toString());
    notifyListeners();
  }

  Future<void> _loadThemeMode() async {
    String? themeValue = await _secureStorage.read(key: Constants.themeKey);
    if (themeValue != null) {
      if (themeValue == ThemeMode.dark.toString()) {
        _themeMode = ThemeMode.dark;
      } else if (themeValue == ThemeMode.light.toString()) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.system;
      }
      notifyListeners();
    }
  }
}
