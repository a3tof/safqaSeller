abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  /// true  → response message was "Login successful As Seller"
  /// false → response message was "Login successful As User"
  final bool isSeller;
  LoginSuccess({required this.isSeller});
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
