import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safqaseller/core/utils/app_constants.dart';
import 'package:safqaseller/features/auth/model/models/login_model.dart';
import 'package:safqaseller/features/auth/model/models/social_auth_models.dart';
import 'package:safqaseller/features/auth/model/repositories/auth_repository.dart';
import 'package:safqaseller/features/auth/view_model/login/login_view_model_state.dart';

class LoginViewModel extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginViewModel(this.authRepository) : super(LoginInitial());

  bool _googleSignInInitialized = false;

  Future<void> _initGoogleSignIn() async {
    if (_googleSignInInitialized) return;
    await GoogleSignIn.instance.initialize(
      serverClientId: AppConstants.googleWebClientId,
    );
    _googleSignInInitialized = true;
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    if (kDebugMode) print('LoginViewModel: starting login…');
    emit(LoginLoading());

    try {
      await authRepository.loginUser(
        LoginRequestModel(email: email, password: password),
      );
      if (kDebugMode) print('LoginViewModel: login successful');
      emit(LoginSuccess());
    } catch (e) {
      final message = _clean(e);
      if (kDebugMode) print('LoginViewModel: login failed — $message');
      emit(LoginError(message));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());

    try {
      await _initGoogleSignIn();

      final GoogleSignInAccount account =
          await GoogleSignIn.instance.authenticate(
        scopeHint: ['email', 'profile'],
      );

      final GoogleSignInAuthentication auth = account.authentication;
      final String? idToken = auth.idToken;

      if (kDebugMode) {
        print('Google Login Success — email: ${account.email}');
        print('ID Token: $idToken');
      }

      if (idToken == null) {
        emit(LoginError(
          'Could not retrieve Google ID token. '
          'Ensure the Web Client ID is correctly configured.',
        ));
        return;
      }

      await authRepository.loginWithGoogle(
        GoogleAuthRequestModel(idToken: idToken),
      );

      if (kDebugMode) print('LoginViewModel: Google login successful');
      emit(LoginSuccess());
    } on GoogleSignInException catch (e) {
      if (kDebugMode) {
        print('Google sign-in exception: ${e.code.name} — ${e.description}');
      }

      final desc = (e.description ?? '').toLowerCase();
      final isUserCancellation = e.code.name == 'canceled' &&
          (desc.isEmpty ||
              desc.contains('user cancel') ||
              desc.contains('user dismiss') ||
              desc.contains('sign_in_cancelled'));

      // "reauth failed" / "api not connected" = app not registered in Google Console
      final isConfigError = desc.contains('reauth') ||
          desc.contains('api_not_connected') ||
          desc.contains('not configured');

      if (isUserCancellation) {
        emit(LoginInitial());
      } else if (isConfigError) {
        emit(LoginError(
          'Google sign-in is not configured for this app. '
          'Register the package name and SHA-1 fingerprint in Google Cloud Console.',
        ));
      } else {
        final msg = e.description?.isNotEmpty == true
            ? e.description!
            : 'Google sign-in failed. Please check your internet connection and try again.';
        emit(LoginError(msg));
      }
    } catch (e) {
      final message = _clean(e);
      if (kDebugMode) print('Google login exception: $message');
      emit(LoginError(message));
    }
  }

  Future<void> loginWithFacebook() async {
    emit(LoginLoading());

    try {
      final result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!.tokenString;

        if (kDebugMode) {
          print('Facebook Login Success');
          print('Access Token: $accessToken');
        }

        await authRepository.loginWithFacebook(
          FacebookAuthRequestModel(accessToken: accessToken),
        );

        if (kDebugMode) print('LoginViewModel: Facebook login successful');
        emit(LoginSuccess());
      } else if (result.status == LoginStatus.cancelled) {
        if (kDebugMode) print('Facebook login cancelled by user');
        emit(LoginInitial());
      } else {
        final msg = result.message ?? 'Facebook login failed';
        if (kDebugMode) print('Facebook login error: $msg');
        emit(LoginError(msg));
      }
    } on MissingPluginException {
      if (kDebugMode) {
        print('Facebook login: MissingPluginException — native setup missing');
      }
      emit(LoginError(
        'Facebook login is not configured. '
        'Add Facebook App ID and activities to AndroidManifest.xml.',
      ));
    } catch (e) {
      final message = _clean(e);
      if (kDebugMode) print('Facebook login exception: $message');
      emit(LoginError(message));
    }
  }

  String _clean(Object e) {
    String msg = e.toString();
    if (msg.startsWith('Exception: ')) msg = msg.replaceFirst('Exception: ', '');
    return msg;
  }
}
