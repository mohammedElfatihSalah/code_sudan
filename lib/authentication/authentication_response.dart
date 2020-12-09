class AuthenticationResponse {
  final String errorMessage;
  final bool isThereError;
  final bool isSuccess;

  AuthenticationResponse(
      {this.errorMessage, this.isThereError, this.isSuccess});
}
