import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/constants.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/generated/l10n.dart';

class TermsAndConditionsViewBody extends StatelessWidget {
  const TermsAndConditionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding.sp,
          vertical: 24.sp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildParagraph(context, s.termsPlatformCompliance),
            _buildParagraph(context, s.termsAccurateInfo),
            _buildParagraph(context, s.termsSuspendAccounts),
            _buildParagraph(context, s.termsMonitored),
            _buildSectionHeader(context, s.termsBuyerAppTitle),
            _buildSectionHeader(context, s.termsAccountUsageTitle),
            _buildParagraph(context, s.termsBuyerAge),
            _buildParagraph(context, s.termsBuyerCredentials),
            _buildParagraph(context, s.termsBuyerMultipleAccounts),
            _buildSectionHeader(context, s.termsBiddingRulesTitle),
            _buildParagraph(context, s.termsBindingBids),
            _buildParagraph(context, s.termsHighestBidWins),
            _buildParagraph(context, s.termsProxyBiddingRules),
            _buildParagraph(context, s.termsManipulateBids),
            _buildSectionHeader(context, s.termsPaymentsTitle),
            _buildParagraph(context, s.termsWalletBalance),
            _buildParagraph(context, s.termsSecurityDeposits),
            _buildParagraph(context, s.termsRefundsPolicy),
            _buildSectionHeader(context, s.termsDisputesTitle),
            _buildParagraph(context, s.termsRaiseDisputes),
            _buildParagraph(context, s.termsDisputeDecisions),
            _buildSectionHeader(context, s.termsSellerAppTitle),
            _buildSectionHeader(context, s.termsSellerRegTitle),
            _buildParagraph(context, s.termsSellerVerification),
            _buildParagraph(context, s.termsSellerApproval),
            _buildParagraph(context, s.termsSellerAccuracy),
            _buildSectionHeader(context, s.termsAuctionMgmtTitle),
            _buildParagraph(context, s.termsHonestDescriptions),
            _buildParagraph(context, s.termsAuctionRules),
            _buildParagraph(context, s.termsNoModifyActive),
            _buildSectionHeader(context, s.termsDeliveryTitle),
            _buildParagraph(context, s.termsTimelyDelivery),
            _buildParagraph(context, s.termsDeliveryInfo),
            _buildParagraph(context, s.termsFailureToDeliver),
            _buildSectionHeader(context, s.termsFeesTitle),
            _buildParagraph(context, s.termsPlatformFees),
            _buildParagraph(context, s.termsTrackEarnings),
            _buildSectionHeader(context, s.termsNotifPolicyTitle),
            _buildParagraph(context, s.termsNotifGenerated),
            _buildParagraph(context, s.termsNotifInformational),
            _buildParagraph(context, s.termsReviewNotif),
            _buildSectionHeader(context, s.termsPrivacyDataTitle),
            _buildParagraph(context, s.termsDataCollected),
            _buildParagraph(context, s.termsDataProtected),
            _buildParagraph(context, s.termsNoShareData),
            _buildSectionHeader(context, s.termsLiabilityTitle),
            _buildParagraph(context, s.termsNotResponsible),
            _buildParagraph(context, s.termsDowntime),
            _buildParagraph(context, s.termsIntermediary),
            _buildSectionHeader(context, s.termsChangesTitle),
            _buildParagraph(context, s.termsUpdatedAnytime),
            _buildParagraph(context, s.termsContinuedUse),
            SizedBox(height: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(top: 8.sp, bottom: 4.sp),
      child: Text(
        text,
        style: TextStyles.regular16(context).copyWith(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF4D4D4D),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildParagraph(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.sp),
      child: Text(
        text,
        style: TextStyles.regular16(context).copyWith(
          fontWeight: FontWeight.w500,
          color: const Color(0xFF4D4D4D),
          height: 1.5,
        ),
      ),
    );
  }
}
