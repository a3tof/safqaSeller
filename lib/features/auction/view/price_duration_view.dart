import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/auction/view/lot_detail_view.dart';

class PriceDurationView extends StatefulWidget {
  const PriceDurationView({super.key});

  static const String routeName = 'priceDurationView';

  @override
  State<PriceDurationView> createState() => _PriceDurationViewState();
}

class _PriceDurationViewState extends State<PriceDurationView> {
  final TextEditingController _startingPriceController =
      TextEditingController(text: '100,000');
  String _selectedBid = '500';
  String _selectedDuration = '7 days';

  @override
  void dispose() {
    _startingPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context: context, title: 'Price & Duration'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionLabel(label: 'Starting Price'),
              SizedBox(height: 6.h),
              _InputField(
                controller: _startingPriceController,
              ),
              SizedBox(height: 16.h),
              const _SectionLabel(label: 'Bid Increment'),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Expanded(
                    child: _ChoiceChipBox(
                      label: '100',
                      selected: _selectedBid == '100',
                      onTap: () {
                        setState(() {
                          _selectedBid = '100';
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: _ChoiceChipBox(
                      label: '300',
                      selected: _selectedBid == '300',
                      onTap: () {
                        setState(() {
                          _selectedBid = '300';
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: _ChoiceChipBox(
                      label: '500',
                      selected: _selectedBid == '500',
                      onTap: () {
                        setState(() {
                          _selectedBid = '500';
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: _ChoiceChipBox(
                      label: 'Specify',
                      selected: _selectedBid == 'Specify',
                      onTap: () {
                        setState(() => _selectedBid = 'Specify');
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              const _SectionLabel(label: 'Auction Duration'),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Expanded(
                    child: _ChoiceChipBox(
                      label: '24 hours',
                      selected: _selectedDuration == '24 hours',
                      onTap: () {
                        setState(() {
                          _selectedDuration = '24 hours';
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: _ChoiceChipBox(
                      label: '3 days',
                      selected: _selectedDuration == '3 days',
                      onTap: () {
                        setState(() {
                          _selectedDuration = '3 days';
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: _ChoiceChipBox(
                      label: '7 days',
                      selected: _selectedDuration == '7 days',
                      onTap: () {
                        setState(() {
                          _selectedDuration = '7 days';
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: _ChoiceChipBox(
                      label: 'Specify',
                      selected: _selectedDuration == 'Specify',
                      onTap: () {
                        setState(() => _selectedDuration = 'Specify');
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Your auction ends on',
                      style: TextStyles.regular12(context).copyWith(
                        color: const Color(0xFF666666),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Sun, Feb 22, 2026 at 5:00 PM',
                      style: TextStyles.semiBold14(context).copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _PrimaryButton(
                label: 'Boost & Publish',
                onTap: () {
                  Navigator.pushNamed(context, LotDetailView.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyles.regular12(context).copyWith(color: Colors.black),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    this.controller,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyles.semiBold14(context).copyWith(
        color: AppColors.primaryColor,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: const BorderSide(color: Color(0xFFE4E4E4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

class _ChoiceChipBox extends StatelessWidget {
  const _ChoiceChipBox({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.secondaryColor : Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: selected ? AppColors.primaryColor : const Color(0xFFE4E4E4),
          ),
        ),
        child: Text(
          label,
          style: TextStyles.regular11(context).copyWith(
            color: selected ? AppColors.primaryColor : const Color(0xFF888888),
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          label,
          style: TextStyles.semiBold14(context).copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
