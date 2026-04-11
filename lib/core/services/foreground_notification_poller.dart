import 'dart:async';

import 'package:safqaseller/core/services/notification_service.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/features/notifications/model/repositories/notifications_repository.dart';

class ForegroundNotificationPoller {
  ForegroundNotificationPoller({
    required NotificationsRepository notificationsRepository,
    required NotificationService notificationService,
    required CacheHelper cacheHelper,
  }) : _notificationsRepository = notificationsRepository,
       _notificationService = notificationService,
       _cacheHelper = cacheHelper;

  final NotificationsRepository _notificationsRepository;
  final NotificationService _notificationService;
  final CacheHelper _cacheHelper;

  Timer? _timer;
  bool _isPolling = false;

  void start({Duration interval = const Duration(minutes: 15)}) {
    final shouldRun =
        (_cacheHelper.getData(key: CacheKeys.isLoggedIn) as bool?) ?? false;
    if (!shouldRun) {
      stop();
      return;
    }

    if (_timer?.isActive ?? false) {
      return;
    }

    unawaited(_poll());
    _timer = Timer.periodic(interval, (_) {
      unawaited(_poll());
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _poll() async {
    if (_isPolling) {
      return;
    }

    if (!_notificationService.isNotificationsEnabled) {
      return;
    }

    final token = _cacheHelper.getData(key: CacheKeys.token) as String?;
    if (token == null || token.isEmpty) {
      return;
    }

    _isPolling = true;
    try {
      final notifications = await _notificationsRepository.getNotifications();
      await _notificationService.showNewNotifications(notifications);
    } catch (_) {
      // Keep polling resilient to network and API failures.
    } finally {
      _isPolling = false;
    }
  }
}
