import 'extensions.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ange din e-postadress';
    }
    if (!value.isValidEmail) {
      return 'Ange en giltig e-postadress';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ange ditt lösenord';
    }
    if (!value.isValidPassword) {
      return 'Lösenordet måste vara minst 6 tecken';
    }
    return null;
  }
}
