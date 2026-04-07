import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_images.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  static const String routeName = 'historyView';

  static const _items = <_HistoryItem>[
    _HistoryItem(
      tag: 'Lot#84184181',
      title: '3 Private Cars',
      bids: '68',
      timeLeft: '1d : 20h',
      price: '\$10,000,000',
    ),
    _HistoryItem(
      tag: '#84184181',
      title: 'Mercedes C180 2024',
      bids: '68',
      mileage: '70,000',
      timeLeft: '1d : 20h',
      price: '\$10,000,000',
    ),
    _HistoryItem(
      tag: 'Lot#84184181',
      title: '3 Private Cars',
      bids: '68',
      timeLeft: '1d : 20h',
      price: '\$10,000,000',
    ),
    _HistoryItem(
      tag: '#84184181',
      title: 'Mercedes C180 2024',
      bids: '68',
      mileage: '70,000',
      timeLeft: '1d : 20h',
      price: '\$10,000,000',
    ),
    _HistoryItem(
      tag: '#84184181',
      title: 'Mercedes C180 2024',
      bids: '68',
      mileage: '70,000',
      timeLeft: '1d : 20h',
      price: '\$10,000,000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryColor,
            size: 22.sp,
          ),
        ),
        title: Text(
          'History',
          style: TextStyles.bold28(context).copyWith(
            color: AppColors.primaryColor,
            fontFamily: 'AlegreyaSC',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.primaryColor,
              size: 26.sp,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 16.h),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '10 Auctions',
                style: TextStyles.regular11(context).copyWith(
                  color: const Color(0xFF444444),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          ..._items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _HistoryCard(item: item),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.item});

  final _HistoryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFD6DCE5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              Assets.imagesFrame1,
              width: 84.w,
              height: 76.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.tag,
                    style: TextStyles.regular11(context).copyWith(
                      color: const Color(0xFF8B8B8B),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    item.title,
                    style: TextStyles.medium16(context).copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 4.h,
                    children: [
                      _MetaItem(
                        icon: Icons.gavel_rounded,
                        value: item.bids,
                      ),
                      if (item.mileage != null)
                        _MetaItem(
                          icon: Icons.speed_rounded,
                          value: item.mileage!,
                          iconColor: const Color(0xFFE05555),
                        ),
                      _MetaItem(
                        icon: Icons.hourglass_empty_rounded,
                        value: item.timeLeft,
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    item.price,
                    style: TextStyles.bold16(context).copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.icon,
    required this.value,
    this.iconColor,
  });

  final IconData icon;
  final String value;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 13.sp,
          color: iconColor ?? const Color(0xFF7A7A7A),
        ),
        SizedBox(width: 4.w),
        Text(
          value,
          style: TextStyles.regular12(context).copyWith(
            color: const Color(0xFF7A7A7A),
          ),
        ),
      ],
    );
  }
}

class _HistoryItem {
  const _HistoryItem({
    required this.tag,
    required this.title,
    required this.bids,
    this.mileage,
    required this.timeLeft,
    required this.price,
  });

  final String tag;
  final String title;
  final String bids;
  final String? mileage;
  final String timeLeft;
  final String price;
}
