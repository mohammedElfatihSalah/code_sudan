import 'dart:convert';

import 'package:app_inter_2/authentication/authentication-interface/i_authentication.dart';
import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/authentication/authentication_response.dart';
import 'package:app_inter_2/util/shared_pref_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String BASE_URL = 'http:' + '//' + '192.168.43.84:5000/users';

class NodeJsAuthentication extends IAuthentication {
  @override
  Future<User> currentUser() async {
    SharedPrefManager manager = await SharedPrefManager.getInstance();
    User user = manager.getUser();
    if (user.isLogged) return user;
    return null;
  }

  @override
  Future<AuthenticationResponse> login(User user) async {
    print(BASE_URL);
    SharedPrefManager manager = await SharedPrefManager.getInstance();

    String name = user.name;
    String password = user.password;

    http.Response response = await http
        .post(BASE_URL + '/login', body: {"name": name, 'password': password});

    if (response != null) {
      String body = response.body;
      Map bodyJson = jsonDecode(body);
      bool isSuccess = bodyJson['success'];

      if (isSuccess) {
        String token = bodyJson['token'];
        String id = bodyJson['id'];
        User user1 =
            User(id: id, name: user.name, email: user.email, token: token);
        manager.saveUser(user1);
        return AuthenticationResponse(
          isSuccess: true,
        );
      } else {
        return AuthenticationResponse(
            isSuccess: false,
            errorMessage: bodyJson['message'],
            isThereError: true);
      }
    } else {
      return AuthenticationResponse(
          isSuccess: false, errorMessage: 'Server error', isThereError: true);
    }
  }

  @override
  Future<AuthenticationResponse> logout(User user) async {
    SharedPrefManager manager = await SharedPrefManager.getInstance();
    manager.logout();
    return AuthenticationResponse(
      isSuccess: true,
    );
  }

  @override
  Future<AuthenticationResponse> signUp(User user) async {
    print(BASE_URL);
    String name = user.name;
    String email = user.email;
    String password = user.password;

    http.Response response = await http.post(BASE_URL + '/register',
        body: {"name": name, 'email': email, 'password': password});

    if (response != null) {
      String body = response.body;
      Map bodyJson = jsonDecode(body);
      bool isSuccess = bodyJson['success'];

      if (isSuccess) {
        return AuthenticationResponse(
          isSuccess: true,
        );
      } else {
        return AuthenticationResponse(
            isSuccess: false,
            errorMessage: bodyJson['message'],
            isThereError: true);
      }
    } else {
      return AuthenticationResponse(
          isSuccess: false, errorMessage: 'Server error', isThereError: true);
    }
  }
}