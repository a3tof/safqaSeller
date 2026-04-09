import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/history/model/models/history_models.dart';
import 'package:safqaseller/features/history/view/widgets/history_card.dart';
import 'package:safqaseller/features/history/view_model/history_view_model.dart';
import 'package:safqaseller/features/history/view_model/history_view_model_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryViewBody extends StatefulWidget {
  const HistoryViewBody({super.key});

  @override
  State<HistoryViewBody> createState() => _HistoryViewBodyState();
}

class _HistoryViewBodyState extends State<HistoryViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
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
      body: BlocBuilder<HistoryViewModel, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading || state is HistoryInitial) {
            return Skeletonizer(
              enabled: true,
              child: _HistoryList(
                totalCount: 43,
                items: _skeletonHistoryItems,
                currentPage: 1,
                totalPages: 5,
                onRefresh: () async {},
                onPageSelected: (_) {},
              ),
            );
          }

          if (state is HistoryFailure) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyles.regular14(
                        context,
                      ).copyWith(color: const Color(0xFF666666)),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<HistoryViewModel>().loadPage(1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final success = state as HistorySuccess;
          return _HistoryList(
            totalCount: success.totalCount,
            items: success.items,
            currentPage: success.currentPage,
            totalPages: success.totalPages,
            onRefresh: () => context.read<HistoryViewModel>().refresh(),
            onPageSelected: (page) =>
                context.read<HistoryViewModel>().goToPage(page),
          );
        },
      ),
    );
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList({
    required this.totalCount,
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.onRefresh,
    required this.onPageSelected,
  });

  final int totalCount;
  final List<HistoryItem> items;
  final int currentPage;
  final int totalPages;
  final Future<void> Function() onRefresh;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    final hasItems = items.isNotEmpty;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 20.h),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _HistoryHeader(totalCount: totalCount),
          ),
          if (!hasItems)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Text(
                  'No history found.',
                  style: TextStyles.regular14(
                    context,
                  ).copyWith(color: const Color(0xFF666666)),
                ),
              ),
            )
          else
            ...items.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: HistoryCard(item: item),
              ),
            ),
          if (hasItems && totalPages > 1)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: _HistoryPagination(
                currentPage: currentPage,
                totalPages: totalPages,
                onPageSelected: onPageSelected,
              ),
            ),
        ],
      ),
    );
  }
}

class _HistoryPagination extends StatelessWidget {
  const _HistoryPagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    final pages = _visiblePages();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PaginationArrowButton(
          icon: Icons.chevron_left,
          isEnabled: currentPage > 1,
          onTap: () => onPageSelected(currentPage - 1),
        ),
        SizedBox(width: 6.w),
        ...pages.map(
          (page) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: _PaginationButton(
              page: page,
              isSelected: page == currentPage,
              onTap: () => onPageSelected(page),
            ),
          ),
        ),
        SizedBox(width: 6.w),
        _PaginationArrowButton(
          icon: Icons.chevron_right,
          isEnabled: currentPage < totalPages,
          onTap: () => onPageSelected(currentPage + 1),
        ),
      ],
    );
  }

  List<int> _visiblePages() {
    if (totalPages <= 5) {
      return List<int>.generate(totalPages, (index) => index + 1);
    }

    if (currentPage <= 3) {
      return const [1, 2, 3, 4, 5];
    }

    if (currentPage >= totalPages - 2) {
      return List<int>.generate(5, (index) => totalPages - 4 + index);
    }

    return List<int>.generate(5, (index) => currentPage - 2 + index);
  }
}

class _PaginationButton extends StatelessWidget {
  const _PaginationButton({
    required this.page,
    required this.isSelected,
    required this.onTap,
  });

  final int page;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Container(
        width: 38.w,
        height: 38.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFFD9D9D9),
          ),
        ),
        child: Text(
          '$page',
          style: TextStyles.semiBold13(context).copyWith(
            color: isSelected ? Colors.white : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}

class _PaginationArrowButton extends StatelessWidget {
  const _PaginationArrowButton({
    required this.icon,
    required this.isEnabled,
    required this.onTap,
  });

  final IconData icon;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFD9D9D9)),
        ),
        child: Icon(
          icon,
          color: isEnabled ? AppColors.primaryColor : const Color(0xFFBDBDBD),
          size: 22.sp,
        ),
      ),
    );
  }
}

class _HistoryHeader extends StatelessWidget {
  const _HistoryHeader({required this.totalCount});

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '$totalCount Auctions',
            style: TextStyles.regular11(
              context,
            ).copyWith(color: const Color(0xFF444444)),
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          icon: Icon(Icons.file_download_outlined, size: 18.sp),
          label: Text(
            'Export',
            style: TextStyles.semiBold13(context).copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

final List<HistoryItem> _skeletonHistoryItems = List.generate(
  10,
  (index) => HistoryItem(
    id: index,
    lotNumber: '84184$index',
    title: 'Mercedes C180 2024',
    status: index.isEven ? AuctionStatus.active : AuctionStatus.finished,
    bidsCount: 68,
    timeLeft: '1d : 20h',
    endDate: DateTime(2026, 4, 8),
    price: 10000000,
    imageUrl: null,
    mileage: '70,000',
  ),
);
