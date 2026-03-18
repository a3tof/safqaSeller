import 'package:safqaseller/features/forgot_password/view_model/forgot_password_view_model.dart';

enum VerificationFlow { registration, forgotPassword }

class VerificationCodeArgs {
  final String email;
  final VerificationFlow flow;

  /// Only for [VerificationFlow.registration] — used to auto-login after confirmation.
  final String? password;

  /// Carried through the forgot-password flow so all 3 screens share one instance.
  final ForgotPasswordViewModel? forgotPasswordViewModel;

  const VerificationCodeArgs({
    required this.email,
    required this.flow,
    this.password,
    this.forgotPasswordViewModel,
  });
}

class CreatePasswordArgs {
  final String email;
  final String token;
  final ForgotPasswordViewModel forgotPasswordViewModel;

  const CreatePasswordArgs({
    required this.email,
    required this.token,
    required this.forgotPasswordViewModel,
  });
}
