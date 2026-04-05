import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/auth/model/models/register_model.dart';
import 'package:safqaseller/features/auth/model/repositories/auth_repository.dart';
import 'package:safqaseller/features/auth/view_model/register/register_view_model_state.dart';

import 'package:safqaseller/features/auth/model/models/location_model.dart';

class RegisterViewModel extends Cubit<RegisterState> {
  final AuthRepository authRepository;

  List<LocationModel> countries = [];
  List<LocationModel> cities = [];
  LocationModel? selectedCountry;
  LocationModel? selectedCity;

  RegisterViewModel(this.authRepository) : super(RegisterInitial());

  Future<void> loadCountries() async {
    emit(RegisterLocationsLoading());
    try {
      countries = await authRepository.getCountries();
      emit(RegisterLocationsLoaded());
    } catch (e) {
      if (kDebugMode) debugPrint('RegisterViewModel getCountries error: $e');
      emit(RegisterLocationsError(_clean(e)));
    }
  }

  Future<void> loadCities(int countryId) async {
    selectedCity = null;
    cities = [];
    emit(RegisterLocationsLoading());
    try {
      cities = await authRepository.getCities(countryId);
      emit(RegisterLocationsLoaded());
    } catch (e) {
      if (kDebugMode) debugPrint('RegisterViewModel getCities error: $e');
      emit(RegisterLocationsError(_clean(e)));
    }
  }

  Future<void> userRegister({
    required String fullName,
    required String email,
    required String password,
    required String birthDate,
    required int gender,
    required int cityId,
    required String phoneNumber,
  }) async {
    emit(RegisterLoading());

    try {
      final response = await authRepository.registerUser(
        RegisterRequestModel(
          fullName: fullName,
          email: email,
          password: password,
          birthDate: birthDate,
          gender: gender,
          cityId: cityId,
          phoneNumber: phoneNumber,
        ),
      );
      emit(RegisterSuccessEmailSent(
        email,
        password,
        message: response.message ?? '',
      ));
    } catch (e) {
      final message = _clean(e);

      // Server sends a 400 when OTP already exists for this email — still navigate
      if (_isOtpRelated(message)) {
        if (kDebugMode) debugPrint('RegisterViewModel: OTP already sent → navigate');
        emit(RegisterSuccessEmailSent(email, password, message: message));
      } else {
        if (kDebugMode) debugPrint('RegisterViewModel error: $message');
        emit(RegisterError(message));
      }
    }
  }

  /// Returns true when the error message means an OTP already exists.
  bool _isOtpRelated(String msg) {
    final lower = msg.toLowerCase();
    return lower.contains('otp') ||
        lower.contains('verification') ||
        lower.contains('check your email') ||
        lower.contains('already sent');
  }

  String _clean(Object e) {
    String msg = e.toString();
    if (msg.startsWith('Exception: ')) msg = msg.replaceFirst('Exception: ', '');
    return msg;
  }
}
