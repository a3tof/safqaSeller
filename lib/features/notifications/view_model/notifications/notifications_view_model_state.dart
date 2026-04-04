import 'package:safqaseller/features/notifications/model/models/notification_model.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;

  NotificationsSuccess({required this.notifications});
}

class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError(this.message);
}
