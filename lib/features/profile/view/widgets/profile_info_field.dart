import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';

class ProfileInfoField extends StatelessWidget {
  const ProfileInfoField({
    super.key,
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE6E9E9), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              style: TextStyles.regular14(context).copyWith(
                color: AppColors.primaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
