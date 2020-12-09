import 'dart:math';

import 'package:app_inter_2/util/user_validator.dart';
import 'package:test/test.dart';

void main() {
  test("test user name validate method", () {
    String validUserName = 'mohamedElfatih';
    String invalidUserName1 = '1mohammedelfatih';
    String invalidUserName2 = 'Mohamm';
    String invalidUserName3 = '';

    expect(null, UserValidator.validateUserName(validUserName));
    expect(true, UserValidator.validateUserName(invalidUserName1) != null);
    expect(true, UserValidator.validateUserName(invalidUserName2) != null);
    expect(true, UserValidator.validateUserName(invalidUserName3) != null);
  });

  test('test valid password', () {
    String validPassword = '1234msms11';
    String invalidPassword1 = '1234';
    String invalidPassword2 = '12345678';
    String invalidPassword3 = 'mohameddmdk';
    String invalidPassword4 = '';

    expect(true, UserValidator.validateUserPassword(validPassword) == null);
    expect(true, UserValidator.validateUserPassword(invalidPassword1) != null);
    expect(true, UserValidator.validateUserPassword(invalidPassword4) != null);
    expect(true, UserValidator.validateUserPassword(invalidPassword3) != null);
    expect(true, UserValidator.validateUserPassword(invalidPassword2) != null);
  });

  test('test valid email', () {
    String validEmail = 'mohammed@gmail.com';
    String invalidEmail1 = 'mohammed';

    expect(true, UserValidator.validateUserEmail(validEmail) == null);
    expect(true, UserValidator.validateUserEmail(invalidEmail1) != null);
  });

  test('test equal password', () {
    String pass1 = 'mohammed1';
    String pass2 = 'mohammed2';

    expect(false, UserValidator.validateUserRePassword(pass1, pass2) == null);
  });
}
