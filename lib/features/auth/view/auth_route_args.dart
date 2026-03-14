enum VerificationFlow { registration, forgotPassword }

class VerificationCodeArgs {
  final String email;
  final VerificationFlow flow;

  /// Only used in the registration flow to auto-login after OTP confirmation.
  final String? password;

  const VerificationCodeArgs({
    required this.email,
    required this.flow,
    this.password,
  });
}

class CreatePasswordArgs {
  final String email;
  final String token;

  const CreatePasswordArgs({required this.email, required this.token});
}
