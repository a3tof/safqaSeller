import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/auth/model/repositories/auth_repository.dart';
import 'package:safqaseller/features/auth/view_model/logout/logout_view_model_state.dart';

class LogoutViewModel extends Cubit<LogoutState> {
  final AuthRepository authRepository;

  LogoutViewModel(this.authRepository) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await authRepository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      String msg = e.toString();
      if (msg.startsWith('Exception: ')) msg = msg.replaceFirst('Exception: ', '');
      emit(LogoutError(msg));
    }
  }
}
