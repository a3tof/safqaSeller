import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/constants.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_images.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/widgets/custom_button.dart';
import 'package:safqaseller/core/widgets/custom_loading_button.dart';
import 'package:safqaseller/core/widgets/custom_text_field.dart';
import 'package:safqaseller/core/widgets/password_field.dart';
import 'package:safqaseller/features/auth/view/forget_password_view.dart';
import 'package:safqaseller/features/auth/view/widgets/dont_have_an_account_widget.dart';
import 'package:safqaseller/features/auth/view/widgets/or_divider.dart';
import 'package:safqaseller/features/auth/view/widgets/social_login_button.dart';
import 'package:safqaseller/features/home/view/home_screen_view.dart';
import 'package:safqaseller/generated/l10n.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    await getIt<CacheHelper>().saveData(key: CacheKeys.isLoggedIn, value: true);
    setState(() => _isLoading = false);
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreenView.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding.sp),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Column(
            children: [
              SizedBox(height: 24.sp),
              CustomTextFormField(
                enabled: !_isLoading,
                hintText: S.of(context).email,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.sp),
              PasswordField(
                enabled: !_isLoading,
                hintText: S.of(context).password,
              ),
              SizedBox(height: 16.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ForgotPasswordView.routeName,
                    ),
                    child: Text(
                      S.of(context).forgotPassword,
                      style: TextStyles.semiBold16(context)
                          .copyWith(color: AppColors.lightPrimaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 33.sp),
              _isLoading
                  ? const CustomLoadingButton()
                  : CustomButton(
                      backgroundColor: AppColors.lightPrimaryColor,
                      textColor: AppColors.secondaryColor,
                      text: S.of(context).signIn,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _login();
                        } else {
                          setState(() =>
                              _autoValidateMode = AutovalidateMode.always);
                        }
                      },
                    ),
              SizedBox(height: 33.sp),
              DontHaveAnAccountWidet(),
              SizedBox(height: 33.sp),
              OrDivider(),
              SizedBox(height: 16.sp),
              SocialLoginButton(
                image: Assets.imagesGoogleIcon,
                title: S.of(context).signInWithGoogle,
                onPressed: _login,
              ),
              SizedBox(height: 16.sp),
              if (defaultTargetPlatform == TargetPlatform.iOS)
                Column(
                  children: [
                    SocialLoginButton(
                      image: Assets.imagesApplIcon,
                      title: S.of(context).signInWithApple,
                      onPressed: _login,
                    ),
                    SizedBox(height: 16.sp),
                  ],
                ),
              SocialLoginButton(
                image: Assets.imagesFacebookIcon,
                title: S.of(context).signInWithFacebook,
                onPressed: _login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
