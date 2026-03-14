import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/constants.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/widgets/custom_button.dart';
import 'package:safqaseller/core/widgets/custom_loading_button.dart';
import 'package:safqaseller/core/widgets/custom_text_field.dart';
import 'package:safqaseller/features/auth/view/auth_route_args.dart';
import 'package:safqaseller/features/auth/view/verification_code_view.dart';
import 'package:safqaseller/generated/l10n.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;
  late String _email;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidateMode = AutovalidateMode.always);
      return;
    }
    _formKey.currentState!.save();

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushNamed(
      context,
      VerificationCodeView.routeName,
      arguments: VerificationCodeArgs(
        email: _email,
        flow: VerificationFlow.forgotPassword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding.sp),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.sp),
                Text(
                  S.of(context).forgetPasswordDescription,
                  style: TextStyles.regular16(context).copyWith(
                    color: const Color(0xFF4C4C4C),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 32.sp),
                Text(S.of(context).email,
                    style: TextStyles.semiBold16(context)),
                SizedBox(height: 8.sp),
                CustomTextFormField(
                  enabled: !_isLoading,
                  onSaved: (value) => _email = value!,
                  hintText: '',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 32.sp),
                _isLoading
                    ? const CustomLoadingButton()
                    : CustomButton(
                        backgroundColor: AppColors.lightPrimaryColor,
                        textColor: AppColors.secondaryColor,
                        onPressed: _submit,
                        text: S.of(context).sendCode,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
