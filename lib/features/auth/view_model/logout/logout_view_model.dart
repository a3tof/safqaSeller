import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/features/auth/view_model/auth/auth_view_model.dart';
import 'package:safqaseller/features/auth/view_model/logout/logout_view_model_state.dart';
import 'package:safqaseller/features/profile/view_model/profile_view_model.dart';

class LogoutViewModel extends Cubit<LogoutState> {
  final AuthViewModel _authViewModel;

  LogoutViewModel(this._authViewModel) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      // AuthViewModel.logout() clears all cached data:
      // token, refreshToken, userId, role, isProfileCompleted, sellerId, isLoggedIn
      await _authViewModel.logout();

      // Also reset ProfileViewModel state
      await getIt<ProfileViewModel>().reset();

      emit(LogoutSuccess());
    } catch (e) {
      String msg = e.toString();
      if (msg.startsWith('Exception: ')) {
        msg = msg.replaceFirst('Exception: ', '');
      }
      emit(LogoutError(msg));
    }
  }
}
