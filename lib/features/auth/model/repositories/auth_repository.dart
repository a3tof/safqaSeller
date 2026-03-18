import 'package:flutter/foundation.dart';
import 'package:safqaseller/core/network/dio_client.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/features/auth/model/models/auth_response_model.dart';
import 'package:safqaseller/features/auth/model/models/confirm_email_model.dart';
import 'package:safqaseller/features/auth/model/models/login_model.dart';
import 'package:safqaseller/features/auth/model/models/register_model.dart';
import 'package:safqaseller/features/auth/model/models/social_auth_models.dart';

class AuthRepository {
  final DioHelper dioHelper;
  final CacheHelper cacheHelper;

  AuthRepository({required this.dioHelper, required this.cacheHelper});

  // ── Register ──────────────────────────────────────────────────────────────

  Future<AuthResponseModel> registerUser(RegisterRequestModel model) async {
    final r = await dioHelper.postData(
      endPoint: 'Auth/register',
      data: model.toJson(),
    );
    _requireSuccess(r);
    final auth = _parse(r.data);
    if (auth.isSuccess != true) {
      throw Exception(auth.message ?? 'Registration failed');
    }
    return auth;
  }

  // ── Login ─────────────────────────────────────────────────────────────────

  Future<AuthResponseModel> loginUser(LoginRequestModel model) async {
    if (kDebugMode) debugPrint('AuthRepository: POST Auth/login');
    final r = await dioHelper.postData(
      endPoint: 'Auth/login',
      data: model.toJson(),
    );
    _requireSuccess(r);
    final auth = _parse(r.data);
    if (auth.isSuccess == true && auth.token != null) {
      await _saveSession(auth);
      return auth;
    }
    throw Exception(auth.message ?? 'Login failed');
  }

  // ── Logout ────────────────────────────────────────────────────────────────

  Future<void> logout() async {
    await cacheHelper.removeData(key: CacheKeys.token);
    await cacheHelper.removeData(key: CacheKeys.refreshToken);
    await cacheHelper.removeData(key: CacheKeys.userId);
    await cacheHelper.saveData(key: CacheKeys.isLoggedIn, value: false);
  }

  // ── Resend confirmation OTP ───────────────────────────────────────────────

  Future<void> resendConfirmationOtp(String email) async {
    final r = await dioHelper.postData(
      endPoint: '/Auth/resend',
      data: {'Email': email},
    );
    _requireSuccess(r);
  }

  // ── Confirm Email ─────────────────────────────────────────────────────────

  Future<void> confirmEmail(ConfirmEmailRequestModel model) async {
    final r = await dioHelper.postData(
      endPoint: 'Auth/confirm-email',
      data: model.toJson(),
    );
    _requireSuccess(r);
  }

  // ── Google Sign-in ────────────────────────────────────────────────────────

  Future<AuthResponseModel> loginWithGoogle(
    GoogleAuthRequestModel model,
  ) async {
    final r = await dioHelper.postData(
      endPoint: 'Auth/google',
      data: model.toJson(),
    );
    _requireSuccess(r);
    return _parseAndSave(r.data);
  }

  // ── Facebook Sign-in ──────────────────────────────────────────────────────

  Future<AuthResponseModel> loginWithFacebook(
    FacebookAuthRequestModel model,
  ) async {
    final r = await dioHelper.postData(
      endPoint: 'Auth/facebook',
      data: model.toJson(),
    );
    _requireSuccess(r);
    return _parseAndSave(r.data);
  }

  // ── Refresh Token ─────────────────────────────────────────────────────────

  Future<AuthResponseModel> refreshToken(RefreshTokenRequestModel model) async {
    final r = await dioHelper.postData(
      endPoint: 'Auth/refresh-token',
      data: model.toJson(),
    );
    _requireSuccess(r);
    return _parseAndSave(r.data);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _requireSuccess(dynamic r) {
    final code = (r as dynamic).statusCode as int?;
    if (code != null && (code < 200 || code > 299)) {
      throw Exception(extractResponseError(r.data, code));
    }
  }

  AuthResponseModel _parse(dynamic data) {
    if (data is! Map<String, dynamic>) {
      throw Exception('Unexpected response format');
    }
    return AuthResponseModel.fromJson(data);
  }

  Future<AuthResponseModel> _parseAndSave(dynamic data) async {
    final auth = _parse(data);
    if (auth.isSuccess == true && auth.token != null) {
      await _saveSession(auth);
      return auth;
    }
    throw Exception(auth.message ?? 'Authentication failed');
  }

  Future<void> _saveSession(AuthResponseModel r) async {
    await cacheHelper.saveData(key: CacheKeys.token, value: r.token);
    if (r.refreshToken != null) {
      await cacheHelper.saveData(
        key: CacheKeys.refreshToken,
        value: r.refreshToken,
      );
    }
    if (r.userId != null) {
      await cacheHelper.saveData(key: CacheKeys.userId, value: r.userId);
    }
    await cacheHelper.saveData(key: CacheKeys.isLoggedIn, value: true);
  }
}
