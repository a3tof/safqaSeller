import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/notifications/model/repositories/notifications_repository.dart';
import 'package:safqaseller/features/notifications/view_model/notifications/notifications_view_model_state.dart';

class NotificationsViewModel extends Cubit<NotificationsState> {
  final NotificationsRepository notificationsRepository;

  NotificationsViewModel(this.notificationsRepository)
      : super(NotificationsInitial());

  Future<void> loadNotifications() async {
    emit(NotificationsLoading());
    try {
      final notifications = await notificationsRepository.getNotifications();
      emit(NotificationsSuccess(notifications: notifications));
    } catch (e) {
      emit(NotificationsError(_clean(e)));
    }
  }

  void markAsRead(int notificationId) {
    final current = state;
    if (current is NotificationsSuccess) {
      final updated = current.notifications.map((n) {
        return n.id == notificationId ? n.copyWith(isRead: true) : n;
      }).toList();
      emit(NotificationsSuccess(notifications: updated));
    }
  }

  void markAllAsRead() {
    final current = state;
    if (current is NotificationsSuccess) {
      final updated =
          current.notifications.map((n) => n.copyWith(isRead: true)).toList();
      emit(NotificationsSuccess(notifications: updated));
    }
  }

  int get unreadCount {
    final current = state;
    if (current is NotificationsSuccess) {
      return current.notifications.where((n) => !n.isRead).length;
    }
    return 0;
  }

  String _clean(Object e) {
    String msg = e.toString();
    if (msg.startsWith('Exception: ')) msg = msg.replaceFirst('Exception: ', '');
    return msg;
  }
}
