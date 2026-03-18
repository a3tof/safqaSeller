import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/auth/model/models/confirm_email_model.dart';
import 'package:safqaseller/features/auth/model/models/login_model.dart';
import 'package:safqaseller/features/auth/model/repositories/auth_repository.dart';
import 'package:safqaseller/features/auth/view_model/confirm_email/confirm_email_view_model_state.dart';

class ConfirmEmailViewModel extends Cubit<ConfirmEmailState> {
  final AuthRepository authRepository;

  ConfirmEmailViewModel(this.authRepository) : super(ConfirmEmailInitial());

  /// Confirms the email OTP. When [password] is provided (registration flow)
  /// it also performs an automatic login so the user goes straight to Home.
  Future<void> confirmEmail({
    required String email,
    required String otp,
    String? password,
  }) async {
    emit(ConfirmEmailLoading());
    try {
      await authRepository.confirmEmail(
        ConfirmEmailRequestModel(email: email, otp: otp),
      );

      // Auto-login if password was passed (registration flow).
      if (password != null && password.isNotEmpty) {
        await authRepository.loginUser(
          LoginRequestModel(email: email, password: password),
        );
        emit(ConfirmEmailAutoLoginSuccess());
      } else {
        emit(ConfirmEmailSuccess());
      }
    } catch (e) {
      emit(ConfirmEmailError(_clean(e)));
    }
  }

  Future<void> resendOtp(String email) async {
    emit(ConfirmEmailLoading());
    try {
      await authRepository.resendConfirmationOtp(email);
      emit(ConfirmEmailOtpResent());
    } catch (e) {
      emit(ConfirmEmailError(_clean(e)));
    }
  }

  String _clean(Object e) {
    String msg = e.toString();
    if (msg.startsWith('Exception: ')) msg = msg.replaceFirst('Exception: ', '');
    return msg;
  }
}
