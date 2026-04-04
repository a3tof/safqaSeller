import 'package:safqaseller/features/notifications/model/models/notification_model.dart';

class NotificationsRepository {
  Future<List<NotificationModel>> getNotifications() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      NotificationModel(
        id: 1,
        title: 'Auction Reminder',
        message:
            'Osama opened a dispute: The item does not match the description/is damaged.',
        timeAgo: '5 min ago',
        type: NotificationType.auctionReminder,
        isRead: false,
      ),
      NotificationModel(
        id: 2,
        title: 'New Auctions',
        message:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        timeAgo: '10 min ago',
        type: NotificationType.newAuction,
        isRead: false,
      ),
      NotificationModel(
        id: 3,
        title: 'Report',
        message:
            'Osama opened a dispute: The item does not match the description/is damaged.',
        timeAgo: '5 min ago',
        type: NotificationType.report,
        isRead: true,
        hasAction: true,
        actionLabel: 'Open Chat',
      ),
      NotificationModel(
        id: 4,
        title: 'Your order is on the way',
        message:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        timeAgo: '25 min ago',
        type: NotificationType.orderOnTheWay,
        isRead: true,
      ),
      NotificationModel(
        id: 5,
        title: 'New Auctions',
        message:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        timeAgo: '30 min ago',
        type: NotificationType.newAuction,
        isRead: true,
      ),
      NotificationModel(
        id: 6,
        title: 'Your order is on the way',
        message:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        timeAgo: '40 min ago',
        type: NotificationType.orderOnTheWay,
        isRead: true,
      ),
    ];
  }
}
