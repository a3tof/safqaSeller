abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

/// Emitted when the server accepted the registration and sent an OTP to email.
/// The view should navigate to VerificationCodeView passing [email] and [password].
class RegisterSuccessEmailSent extends RegisterState {
  final String email;
  final String password;
  final String message;
  RegisterSuccessEmailSent(this.email, this.password, {this.message = ''});
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}
