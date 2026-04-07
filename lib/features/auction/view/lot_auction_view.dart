import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/auction/view/price_duration_view.dart';

class LotAuctionView extends StatefulWidget {
  const LotAuctionView({super.key});

  static const String routeName = 'lotAuctionView';

  @override
  State<LotAuctionView> createState() => _LotAuctionViewState();
}

class _LotAuctionViewState extends State<LotAuctionView> {
  final List<_Condition> _itemConditions = [_Condition.newItem];
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _addItem() {
    setState(() => _itemConditions.add(_Condition.newItem));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context: context, title: 'Lot Auction'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionLabel(label: 'Lot Details'),
              SizedBox(height: 8.h),
              const _UploadBox(label: 'Head Image +', height: 88),
              SizedBox(height: 10.h),
              const _FieldLabel(label: 'Lot Title'),
              SizedBox(height: 4.h),
              const _AuctionTextField(hint: ''),
              SizedBox(height: 8.h),
              const _FieldLabel(label: 'Lot Category'),
              SizedBox(height: 4.h),
              const _AuctionTextField(hint: ''),
              SizedBox(height: 16.h),
              ...List.generate(
                _itemConditions.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 14.h),
                  child: _LotItemCard(
                    index: index + 1,
                    selectedCondition: _itemConditions[index],
                    onConditionChanged: (value) {
                      setState(() => _itemConditions[index] = value);
                    },
                  ),
                ),
              ),
              Center(
                child: TextButton.icon(
                  onPressed: _addItem,
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    size: 18.sp,
                    color: AppColors.primaryColor,
                  ),
                  label: Text(
                    'Add Item',
                    style: TextStyles.semiBold13(context).copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              const _SectionLabel(label: 'Lot Description'),
              SizedBox(height: 8.h),
              _AuctionTextField(
                hint: '',
                controller: _descriptionController,
                minLines: 3,
                maxLines: 3,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _descriptionController,
                    builder: (context, value, _) {
                      return Text(
                        '${value.text.length}/160',
                        style: TextStyles.regular11(context).copyWith(
                          color: const Color(0xFF888888),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              _PrimaryButton(
                label: 'Save & Continue',
                onTap: () {
                  Navigator.pushNamed(context, PriceDurationView.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LotItemCard extends StatelessWidget {
  const _LotItemCard({
    required this.index,
    required this.selectedCondition,
    required this.onConditionChanged,
  });

  final int index;
  final _Condition selectedCondition;
  final ValueChanged<_Condition> onConditionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'Item ($index)'),
        SizedBox(height: 8.h),
        const _UploadBox(label: 'Add Images +', height: 82),
        SizedBox(height: 8.h),
        const Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _InfoChip(icon: Icons.speed_rounded, label: 'Speed'),
            _InfoChip(icon: Icons.settings_outlined, label: 'Gear Type'),
            _InfoChip(icon: Icons.local_gas_station_outlined, label: 'Petrol'),
            _InfoChip(icon: Icons.location_on_outlined, label: 'Location'),
            _InfoChip(icon: Icons.palette_outlined, label: 'Color'),
            _InfoChip(icon: Icons.directions_car_outlined, label: 'Model'),
          ],
        ),
        SizedBox(height: 8.h),
        const _FieldLabel(label: 'Title'),
        SizedBox(height: 4.h),
        const _AuctionTextField(hint: ''),
        SizedBox(height: 8.h),
        const _FieldLabel(label: 'Count'),
        SizedBox(height: 4.h),
        const _AuctionTextField(hint: ''),
        SizedBox(height: 8.h),
        const _FieldLabel(label: 'Warranty INFO'),
        SizedBox(height: 4.h),
        const _AuctionTextField(hint: ''),
        SizedBox(height: 8.h),
        const _FieldLabel(label: 'Condition'),
        SizedBox(height: 4.h),
        _ConditionRow(
          selected: selectedCondition,
          onChanged: onConditionChanged,
        ),
      ],
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
      style: TextStyles.semiBold16(context).copyWith(color: Colors.black),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyles.regular11(context).copyWith(
        color: const Color(0xFF8A8A8A),
      ),
    );
  }
}

class _UploadBox extends StatelessWidget {
  const _UploadBox({required this.label, required this.height});

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyles.regular12(context).copyWith(
            color: const Color(0xFF9A9A9A),
          ),
        ),
      ),
    );
  }
}

class _AuctionTextField extends StatelessWidget {
  const _AuctionTextField({
    required this.hint,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
  });

  final String hint;
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyles.regular13(context),
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: Color(0xFFE4E4E4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE3E3E3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11.sp, color: const Color(0xFF8C8C8C)),
          SizedBox(width: 3.w),
          Text(
            label,
            style: TextStyles.regular11(context).copyWith(
              color: const Color(0xFF8C8C8C),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConditionRow extends StatelessWidget {
  const _ConditionRow({
    required this.selected,
    required this.onChanged,
  });

  final _Condition selected;
  final ValueChanged<_Condition> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 6.h,
      children: _Condition.values.map((condition) {
        return InkWell(
          onTap: () => onChanged(condition),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected == condition
                        ? AppColors.primaryColor
                        : const Color(0xFFBDBDBD),
                  ),
                ),
                child: selected == condition
                    ? Center(
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 6.w),
              Text(
                condition.label,
                style: TextStyles.regular12(context),
              ),
            ],
          ),
        );
      }).toList(),
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

enum _Condition {
  newItem('New'),
  usedLikeNew('Used-Like New'),
  used('Used');

  const _Condition(this.label);

  final String label;
}
