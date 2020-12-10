import 'package:app_inter_2/authentication/authentication-interface/i_authentication.dart';
import 'package:app_inter_2/authentication/user.dart';
import 'package:app_inter_2/authentication/authentication_response.dart';
import 'package:http/http.dart' as http;

class NodeJsAuthentication extends IAuthentication {
  static const String BASE_URL = 'http:' + '//' + '192.168.43.84:5000/users';
  @override
  Future<User> currentUser() {
    return null;
  }

  @override
  Future<AuthenticationResponse> login(User user) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<AuthenticationResponse> logout(User user) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<AuthenticationResponse> signUp(User user) async {
    print(BASE_URL);
    String name = user.name;
    String email = user.email;
    String password = user.password;

    http.Response response = await http.post(BASE_URL + '/register',
        body: {"name": name, 'email': email, 'password': password});

    print(response.body);

    return AuthenticationResponse(
      isSuccess: true,
    );
  }
}
