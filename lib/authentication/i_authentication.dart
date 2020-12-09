import 'package:app_inter_2/authentication/authentication_response.dart';

import 'user.dart';

abstract class IAuthentication {
  Future<AuthenticationResponse> signUp(User user);

  Future<AuthenticationResponse> login(User user);

  Future<AuthenticationResponse> logout(User user);
}
