import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/notifications/model/models/notification_model.dart';
import 'package:safqaseller/features/notifications/view/widgets/notification_item.dart';
import 'package:safqaseller/features/notifications/view_model/notifications/notifications_view_model.dart';
import 'package:safqaseller/features/notifications/view_model/notifications/notifications_view_model_state.dart';

class NotificationsViewBody extends StatefulWidget {
  const NotificationsViewBody({super.key});

  @override
  State<NotificationsViewBody> createState() => _NotificationsViewBodyState();
}

class _NotificationsViewBodyState extends State<NotificationsViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsViewModel>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: BlocBuilder<NotificationsViewModel, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is NotificationsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 48.sp, color: Colors.grey[400]),
                  SizedBox(height: 12.h),
                  Text(
                    state.message,
                    style: TextStyles.regular14(context)
                        .copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () => context
                        .read<NotificationsViewModel>()
                        .loadNotifications(),
                    child: Text(
                      'Retry',
                      style: TextStyles.medium16(context)
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is NotificationsSuccess) {
            if (state.notifications.isEmpty) {
              return const _EmptyNotificationsPlaceholder();
            }

            return _NotificationsList(notifications: state.notifications);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.primaryColor,
          size: 22.sp,
        ),
      ),
      title: Text(
        'Notifications',
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor,
          fontFamily: Localizations.localeOf(context).languageCode == 'ar'
              ? 'Cairo'
              : 'AlegreyaSC',
        ),
      ),
      actions: [
        BlocBuilder<NotificationsViewModel, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsSuccess &&
                state.notifications.any((n) => !n.isRead)) {
              return TextButton(
                onPressed: () =>
                    context.read<NotificationsViewModel>().markAllAsRead(),
                child: Text(
                  'Mark all',
                  style: TextStyles.medium14(context)
                      .copyWith(color: AppColors.primaryColor),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

// ── Notifications list ─────────────────────────────────────────────────────────

class _NotificationsList extends StatelessWidget {
  const _NotificationsList({required this.notifications});
  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
      itemCount: notifications.length,
      separatorBuilder: (_, _) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Stack(
          clipBehavior: Clip.none,
          children: [
            NotificationItem(
              notification: notification,
              onActionTap: () {
                // TODO: navigate to chat when backend is wired
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening chat...')),
                );
              },
            ),
            // Unread dot indicator
            if (!notification.isRead)
              Positioned(
                left: -4.w,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE53935),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────

class _EmptyNotificationsPlaceholder extends StatelessWidget {
  const _EmptyNotificationsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined,
              size: 64.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text(
            'No notifications yet',
            style: TextStyles.medium16(context).copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
