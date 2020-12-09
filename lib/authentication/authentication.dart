import 'package:app_inter_2/authentication/authentication_response.dart';
import 'package:app_inter_2/authentication/i_authentication.dart';
import 'package:app_inter_2/authentication/user.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ParseSdkAuthenticationImpl extends IAuthentication {
  @override
  Future<AuthenticationResponse> login(User user) async {
    ParseUser parseUser = ParseUser(user.name, user.password, user.password);

    ParseResponse parseResponse = await parseUser.login();

    if (parseResponse.success)
      return AuthenticationResponse(
          isSuccess: true, isThereError: false, errorMessage: '');

    return AuthenticationResponse(
        isSuccess: false,
        isThereError: true,
        errorMessage: parseResponse.error.message);
  }

  @override
  Future<AuthenticationResponse> signUp(User user) async {
    ParseUser parseUser =
        ParseUser.createUser(user.name, user.password, user.email);
    ParseResponse parseResponse = await parseUser.signUp();

    if (parseResponse.success)
      return AuthenticationResponse(
          isSuccess: true, isThereError: false, errorMessage: '');

    return AuthenticationResponse(
        isSuccess: false,
        isThereError: true,
        errorMessage: parseResponse.error.message);
  }

  @override
  Future<AuthenticationResponse> logout(User user) async {
    ParseUser parseUser = await ParseUser.currentUser();
    ParseResponse parseResponse = await parseUser.logout();


    if(parseResponse.success){
      return AuthenticationResponse(isSuccess: true,isThereError: false, errorMessage: '');
    }


    return AuthenticationResponse(isSuccess:false,isThereError: true, errorMessage: parseResponse.error.message);
  }
}
