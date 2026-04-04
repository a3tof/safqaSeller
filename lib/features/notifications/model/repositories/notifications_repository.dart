import 'package:dio/dio.dart';
import 'package:safqaseller/core/config/app_config.dart';
import 'package:safqaseller/core/network/dio_client.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/features/notifications/model/models/notification_model.dart';

class NotificationsRepository {
  final DioHelper dioHelper;

  NotificationsRepository({required this.dioHelper});

  // ── GET /api/Notifications/Get-Notifications ──────────────────────────────

  Future<List<NotificationModel>> getNotifications() async {
    final cache = getIt<CacheHelper>();
    final savedTime = cache.getData(key: 'token_time');
    bool needsRefresh = false;
    if (savedTime is String) {
      final dt = DateTime.tryParse(savedTime);
      if (dt != null && DateTime.now().difference(dt).inHours >= 5) {
        needsRefresh = true;
      }
    }

    if (needsRefresh) {
      await _refreshTokenLocally();
    }

    var r = await dioHelper.getData(
      endPoint: 'Notifications/Get-Notifications',
      requiresAuth: true,
    );

    // If still Unauthorized somehow, or no savedTime existed yet and the token was already expired natively
    if (r.statusCode == 401) {
      await _refreshTokenLocally();
      r = await dioHelper.getData(
        endPoint: 'Notifications/Get-Notifications',
        requiresAuth: true,
      );
    }

    _require(r);
    final list = r.data as List<dynamic>;
    return list
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> _refreshTokenLocally() async {
    final cache = getIt<CacheHelper>();
    final token = cache.getData(key: CacheKeys.token);
    if (token != null) {
      // Use a new Dio instance to avoid interceptor loops
      final dio = Dio(BaseOptions(
        baseUrl: AppConfig.baseUrl,
        validateStatus: (_) => true,
        headers: {
          'x-api-key': AppConfig.apiKey,
          'Content-Type': 'application/json',
        },
      ));
      
      final response = await dio.post(
        'Auth/refresh-token',
        data: '"$token"', // Passing expired token as a simple JSON string
      );
      
      if (response.statusCode == 200) {
        final newToken = response.data['token'] ?? response.data['Token'];
        if (newToken != null) {
          await cache.saveData(key: CacheKeys.token, value: newToken);
          await cache.saveData(
            key: 'token_time',
            value: DateTime.now().toIso8601String(),
          );
        }
      }
    }
  }

  // ── DELETE /api/Notifications/Delete-SelectedNotifications ────────────────

  Future<void> deleteNotifications(List<int> ids) async {
    final r = await dioHelper.deleteWithBody(
      endPoint: 'Notifications/Delete-SelectedNotifications',
      data: {'notificationIds': ids},
      requiresAuth: true,
    );
    _require(r);
  }

  // ── Helper ─────────────────────────────────────────────────────────────────

  void _require(Response<dynamic> r) {
    final code = r.statusCode;
    if (code != null && (code < 200 || code > 299)) {
      throw Exception(extractResponseError(r.data, code));
    }
  }
}
