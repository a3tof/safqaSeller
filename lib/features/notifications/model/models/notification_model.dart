enum NotificationType { auctionReminder, newAuction, report, orderOnTheWay }

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String timeAgo;
  final NotificationType type;
  final bool isRead;
  final bool hasAction;
  final String? actionLabel;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.type,
    this.isRead = false,
    this.hasAction = false,
    this.actionLabel,
  });

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      message: message,
      timeAgo: timeAgo,
      type: type,
      isRead: isRead ?? this.isRead,
      hasAction: hasAction,
      actionLabel: actionLabel,
    );
  }
}
