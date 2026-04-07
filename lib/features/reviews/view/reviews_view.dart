import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  static const String routeName = 'reviewsView';

  static const _items = <_ReviewItem>[
    _ReviewItem(
      name: 'Dale Thiel',
      score: '3.8',
      date: '22May2025',
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    _ReviewItem(
      name: 'Dale Thiel',
      score: '3.8',
      date: '22May2025',
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    _ReviewItem(
      name: 'Dale Thiel',
      score: '3.8',
      date: '22May2025',
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    _ReviewItem(
      name: 'Dale Thiel',
      score: '3.8',
      date: '22May2025',
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    _ReviewItem(
      name: 'Dale Thiel',
      score: '3.8',
      date: '22May2025',
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context: context, title: 'Reviews & Ratings'),
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        itemBuilder: (context, index) => _ReviewCard(item: _items[index]),
        separatorBuilder: (_, _) => Divider(
          height: 22.h,
          color: const Color(0xFFE3E3E3),
        ),
        itemCount: _items.length,
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.item});

  final _ReviewItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: const BoxDecoration(
            color: Color(0xFFF1F1F1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            size: 24.sp,
            color: const Color(0xFFC7A28C),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: TextStyles.semiBold15(context).copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    item.date,
                    style: TextStyles.regular11(context).copyWith(
                      color: const Color(0xFFC0C0C0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  ...List.generate(
                    5,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: Icon(
                        index < 4 ? Icons.star_rounded : Icons.star_border_rounded,
                        color: const Color(0xFFFFC107),
                        size: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '(${item.score})',
                    style: TextStyles.regular12(context).copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                item.comment,
                style: TextStyles.regular12(context).copyWith(
                  color: const Color(0xFF8E8E8E),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewItem {
  const _ReviewItem({
    required this.name,
    required this.score,
    required this.date,
    required this.comment,
  });

  final String name;
  final String score;
  final String date;
  final String comment;
}
