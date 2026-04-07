import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_images.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';

class LotDetailView extends StatelessWidget {
  const LotDetailView({super.key});

  static const String routeName = 'lotDetailView';

  static const _items = <_LotDetailItem>[
    _LotDetailItem(name: 'Mercedes C180 2024'),
    _LotDetailItem(name: 'Toyota Corolla 2024'),
    _LotDetailItem(name: 'Kia Cerato 2024'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryColor,
            size: 20.sp,
          ),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Lot#84184181',
                style: TextStyles.semiBold14(context).copyWith(
                  color: AppColors.primaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.favorite_border_rounded,
              size: 18.sp,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: 8.w),
            Text(
              'Edit',
              style: TextStyles.regular12(context).copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3 private cars (Mercedes • Toyota • Kia)',
                      style: TextStyles.semiBold15(context).copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: _DateInfo(
                            title: 'Starts in',
                            value: 'Dec 6:00 PM',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _DateInfo(
                            title: 'Ends in',
                            value: 'Dec 6:00 PM',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    ...List.generate(
                      _items.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _AuctionItemTile(
                          index: index + 1,
                          item: _items[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time Left',
                              style: TextStyles.regular11(context).copyWith(
                                color: const Color(0xFF9A9A9A),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Bid : 20h : 50m : 25s',
                              style: TextStyles.semiBold13(context).copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Starting price',
                            style: TextStyles.regular11(context).copyWith(
                              color: const Color(0xFF9A9A9A),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '\$10,000,000',
                            style: TextStyles.bold16(context).copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Boost & Publish',
                        style: TextStyles.semiBold14(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateInfo extends StatelessWidget {
  const _DateInfo({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE0E6EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.regular11(context).copyWith(
              color: const Color(0xFF7D7D7D),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: TextStyles.semiBold13(context).copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _AuctionItemTile extends StatelessWidget {
  const _AuctionItemTile({
    required this.index,
    required this.item,
  });

  final int index;
  final _LotDetailItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item ($index)',
          style: TextStyles.regular12(context).copyWith(color: Colors.black),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFE6E6E6)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  Assets.imagesFrame1,
                  width: 70.w,
                  height: 48.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyles.semiBold13(context).copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Used',
                      style: TextStyles.regular11(context).copyWith(
                        color: const Color(0xFF919191),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.speed_rounded,
                          size: 12.sp,
                          color: const Color(0xFFE26C6C),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '70,000',
                          style: TextStyles.regular11(context).copyWith(
                            color: const Color(0xFF919191),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                'Details & Docs',
                style: TextStyles.regular11(context).copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LotDetailItem {
  const _LotDetailItem({required this.name});

  final String name;
}
