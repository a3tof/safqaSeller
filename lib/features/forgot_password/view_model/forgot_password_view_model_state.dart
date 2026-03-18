abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

/// OTP sent successfully → navigate to VerificationCodeView
class ForgotPasswordOtpSent extends ForgotPasswordState {
  final String email;
  ForgotPasswordOtpSent(this.email);
}

/// OTP resent successfully
class ForgotPasswordOtpResent extends ForgotPasswordState {}

/// OTP verified → navigate to CreatePasswordView with [email] and [token]
class ForgotPasswordOtpVerified extends ForgotPasswordState {
  final String email;
  final String token;
  ForgotPasswordOtpVerified({required this.email, required this.token});
}

/// Password reset successfully → navigate back to login
class ForgotPasswordResetSuccess extends ForgotPasswordState {}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  ForgotPasswordError(this.message);
}
