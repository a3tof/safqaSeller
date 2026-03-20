import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/features/profile/view/widgets/profile_header_section.dart';
import 'package:safqaseller/features/profile/view/widgets/profile_info_field.dart';
import 'package:safqaseller/features/profile/view/widgets/profile_menu_item.dart';
import 'package:safqaseller/features/profile/view/widgets/profile_metrics_row.dart';
import 'package:safqaseller/features/wallet/view/wallet_view.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            // ── Profile Header (Avatar + Buttons) ──
            const ProfileHeaderSection(),
            SizedBox(height: 20.h),

            // ── Metrics Row (Rating, Users, Deliveries) ──
            const ProfileMetricsRow(),
            SizedBox(height: 24.h),

            // ── User Info Fields ──
            const ProfileInfoField(
              icon: Icons.person_outline,
              value: 'Saeed Ahmed',
            ),
            SizedBox(height: 12.h),
            const ProfileInfoField(
              icon: Icons.email_outlined,
              value: 'saeed.ahmed@gmail.com',
            ),
            SizedBox(height: 12.h),
            const ProfileInfoField(
              icon: Icons.phone_outlined,
              value: '01000000000',
            ),
            SizedBox(height: 12.h),

            // ── Navigation Menu Items ──
            ProfileMenuItem(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Wallet',
              onTap: () {
                Navigator.pushNamed(context, WalletView.routeName);
              },
            ),
            SizedBox(height: 12.h),
            ProfileMenuItem(
              icon: Icons.location_on_outlined,
              label: 'Cairo, Egypt',
              trailingIcon: Icons.keyboard_arrow_down,
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            ProfileMenuItem(
              icon: Icons.access_time,
              label: 'History',
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            ProfileMenuItem(
              icon: Icons.bar_chart_outlined,
              label: 'Statistics',
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            ProfileMenuItem(
              icon: Icons.star_outline,
              label: 'Reviews & Ratings',
              onTap: () {},
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
