import 'package:app_inter_2/localization/Demo.dart';
import 'package:flutter/cupertino.dart';

class UserValidator {
  /*
  1- user name have at least 8 characters
  2- User name doesnot start with number 
  */
  static String validateUserName(String name) {
    final specials = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];

    if (name == null) {
      return 'enter_name';
    }

    if (name.isEmpty) {
      return 'enter_name';
    }

    if (name.length < 8) {
      return 'name_8_characters';
    }

    if (specials.contains(name.substring(0, 1))) {
      return 'name_dont_start_with_number';
    }
    return null;
  }

  /**
   * 1- at least 8 character
   * 2- must contain character and number
   */
  static String validateUserPassword(String password) {
    RegExp characterExpression = RegExp(r'\D');
    RegExp numberExpression = RegExp(r'\d');

    if (password == null) return 'enter_password';

    if (password.isEmpty) return 'enter_password';

    if (password.length < 8) return 'password_8_characters';

    bool containCharacter = characterExpression.hasMatch(password);

    if (!containCharacter) return 'must_contains_character';

    bool containNumber = numberExpression.hasMatch(password);

    if (!containNumber) return 'must_contains_number';

    return null;
  }

  static String validateUserRePassword(String password, String repassword) {
    bool arePasswordEqual = (password == repassword);

    return arePasswordEqual ? null : 'password_not_equal';
  }

  /*
  valid email
   */
  static String validateUserEmail(String email) {
    RegExp emailExpression =
        RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");

    if (email == null) {
      'enter_email';
    }

    if (email.isEmpty) {
      return 'enter_email';
    }

    bool isEmailValid = emailExpression.hasMatch(email);

    if (!isEmailValid) return 'enter_valid_email';

    return null;
  }

  static String validateUserNameWithTranslation(
      BuildContext context, String name) {
    String result = validateUserName(name);
    if (result == null) return result;

    return DemoLocalizations.of(context).translate(result);
  }

  static String validateUserPasswordWithTranslation(
      BuildContext context, String password) {
    String result = validateUserPassword(password);
    if (result == null) return result;

    return DemoLocalizations.of(context).translate(result);
  }

  static String validateUserEmailWithTranslation(
      BuildContext context, String email) {
    String result = validateUserEmail(email);
    if (result == null) return result;

    return DemoLocalizations.of(context).translate(result);
  }

  static String validateRePasswordWithTranslation(
      BuildContext context, String password, String repassword) {
    String result = validateUserRePassword(password, repassword);

    if (result == null) return result;

    return DemoLocalizations.of(context).translate(result);
  }
}
