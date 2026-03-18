import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/forgot_password/model/models/forgot_password_models.dart';
import 'package:safqaseller/features/forgot_password/model/repositories/forgot_password_repository.dart';
import 'package:safqaseller/features/forgot_password/view_model/forgot_password_view_model_state.dart';

class ForgotPasswordViewModel extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository repository;

  ForgotPasswordViewModel(this.repository) : super(ForgotPasswordInitial());

  Future<void> requestOtp(String email) async {
    emit(ForgotPasswordLoading());
    try {
      await repository.requestOtp(ForgotPasswordRequestModel(email: email));
      emit(ForgotPasswordOtpSent(email));
    } catch (e) {
      emit(ForgotPasswordError(_clean(e)));
    }
  }

  Future<void> resendOtp(String email) async {
    emit(ForgotPasswordLoading());
    try {
      await repository.resendOtp(ForgotPasswordRequestModel(email: email));
      emit(ForgotPasswordOtpResent());
    } catch (e) {
      emit(ForgotPasswordError(_clean(e)));
    }
  }

  Future<void> verifyOtp({
    required String email,
    required String code,
  }) async {
    emit(ForgotPasswordLoading());
    try {
      final response = await repository.verifyOtp(
        VerifyOtpRequestModel(email: email, code: code),
      );
      emit(ForgotPasswordOtpVerified(
        email: email,
        token: response.token ?? '',
      ));
    } catch (e) {
      emit(ForgotPasswordError(_clean(e)));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    emit(ForgotPasswordLoading());
    try {
      await repository.resetPassword(
        ResetPasswordRequestModel(
          email: email,
          token: token,
          newPassword: newPassword,
        ),
      );
      emit(ForgotPasswordResetSuccess());
    } catch (e) {
      emit(ForgotPasswordError(_clean(e)));
    }
  }

  String _clean(Object e) {
    String msg = e.toString();
    if (msg.startsWith('Exception: ')) msg = msg.replaceFirst('Exception: ', '');
    return msg;
  }
}
