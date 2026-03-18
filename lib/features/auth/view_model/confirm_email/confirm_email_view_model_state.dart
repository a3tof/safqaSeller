abstract class ConfirmEmailState {}

class ConfirmEmailInitial extends ConfirmEmailState {}

class ConfirmEmailLoading extends ConfirmEmailState {}

class ConfirmEmailSuccess extends ConfirmEmailState {}

/// Emitted when email confirmation AND automatic login both succeeded.
/// The view should navigate directly to the home screen.
class ConfirmEmailAutoLoginSuccess extends ConfirmEmailState {}

class ConfirmEmailOtpResent extends ConfirmEmailState {}

class ConfirmEmailError extends ConfirmEmailState {
  final String message;
  ConfirmEmailError(this.message);
}
