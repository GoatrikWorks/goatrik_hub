import 'package:flutter/material.dart';

extension StringExtensions on String {
  bool get isValidEmail {
    return RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(this);
  }

  bool get isValidPassword {
    // Lösenordskriterier, t.ex. minst 6 tecken
    return this.length >= 6;
  }
}

extension ContextExtensions on BuildContext {
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? Theme.of(this).colorScheme.primary,
      ),
    );
  }
}
