import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';

class ProfileMetricsRow extends StatelessWidget {
  const ProfileMetricsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _MetricItem(
            icon: Icons.star_outline,
            iconColor: const Color(0xFFFFC107),
            value: '4.9',
          ),
          SizedBox(width: 32.w),
          _MetricItem(
            icon: Icons.groups_outlined,
            iconColor: AppColors.primaryColor,
            value: '100',
          ),
          SizedBox(width: 32.w),
          _MetricItem(
            icon: Icons.local_shipping_outlined,
            iconColor: AppColors.primaryColor,
            value: '4.9',
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 22.sp),
        SizedBox(width: 6.w),
        Text(
          value,
          style: TextStyles.semiBold14(context).copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
