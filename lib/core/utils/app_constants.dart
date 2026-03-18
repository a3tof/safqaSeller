import 'package:safqaseller/core/config/app_config.dart';

/// Thin compatibility shim — all values delegate to [AppConfig].
/// Prefer importing [AppConfig] directly in new code.
abstract class AppConstants {
  static const String baseUrl = AppConfig.baseUrl;
  static const String apiKey = AppConfig.apiKey;
  static const String googleWebClientId = AppConfig.googleWebClientId;
}
