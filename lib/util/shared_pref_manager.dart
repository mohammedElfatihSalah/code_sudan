import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/util/user_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static SharedPreferences _sharedPreferences;

  SharedPrefManager._();

  static Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPrefManager _manager;

  static Future<SharedPrefManager> getInstance() async {
    if (_manager == null) {
      _manager = SharedPrefManager._();
      await _init();
    }
    return _manager;
  }

  void saveUser(User user) {
    _sharedPreferences.setString(UserKeys.USER_NAME_KEY, user.name);
    _sharedPreferences.setString(UserKeys.USER_EMAIL_KEY, user.email);
    _sharedPreferences.setString(UserKeys.USER_PASSWORD_KEY, user.password);
    _sharedPreferences.setString(UserKeys.USER_ID_KEY, user.id);
    _sharedPreferences.setBool(UserKeys.USER_LOGIN_KEY, true);
  }

  void logout() {
    _sharedPreferences.setString(UserKeys.USER_NAME_KEY, '');
    _sharedPreferences.setString(UserKeys.USER_PASSWORD_KEY, '');
    _sharedPreferences.setString(UserKeys.USER_ID_KEY, '');
    _sharedPreferences.setBool(UserKeys.USER_LOGIN_KEY, false);
  }

  User getUser() {
    return User(
        name: _sharedPreferences.get(UserKeys.USER_NAME_KEY),
        id: _sharedPreferences.get(UserKeys.USER_ID_KEY),
        email: _sharedPreferences.get(UserKeys.USER_EMAIL_KEY),
        isLogged: _sharedPreferences.get(UserKeys.USER_LOGIN_KEY));
  }
}
