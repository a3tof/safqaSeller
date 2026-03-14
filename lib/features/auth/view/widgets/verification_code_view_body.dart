import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/constants.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/widgets/custom_button.dart';
import 'package:safqaseller/core/widgets/custom_loading_button.dart';
import 'package:safqaseller/core/widgets/custom_pin_box.dart';
import 'package:safqaseller/features/auth/view/auth_route_args.dart';
import 'package:safqaseller/features/auth/view/create_password_view.dart';
import 'package:safqaseller/features/home/view/home_screen_view.dart';
import 'package:safqaseller/generated/l10n.dart';

class VerificationCodeViewBody extends StatefulWidget {
  const VerificationCodeViewBody({super.key, required this.args});
  final VerificationCodeArgs args;

  @override
  State<VerificationCodeViewBody> createState() =>
      _VerificationCodeViewBodyState();
}

class _VerificationCodeViewBodyState extends State<VerificationCodeViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;

  static const int _digitCount = 6;
  static const double _boxSpacing = 8.0;

  final List<TextEditingController> _controllers =
      List.generate(_digitCount, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_digitCount, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _digitCount; i++) {
      final index = i;
      _focusNodes[index].onKeyEvent = (_, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            _controllers[index].text.isEmpty &&
            index > 0) {
          _focusNodes[index - 1].requestFocus();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      };
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidateMode = AutovalidateMode.always);
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (widget.args.flow == VerificationFlow.registration) {
      await getIt<CacheHelper>().saveData(
        key: CacheKeys.isLoggedIn,
        value: true,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).emailConfirmedSuccessfully),
        backgroundColor: Colors.green,
      ));
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreenView.routeName,
        (route) => false,
      );
    } else {
      Navigator.pushNamed(
        context,
        CreatePasswordView.routeName,
        arguments: CreatePasswordArgs(
          email: widget.args.email,
          token: 'mock-token',
        ),
      );
    }
  }

  Future<void> _resend() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(S.of(context).otpResentSuccessfully),
      backgroundColor: Colors.green,
    ));
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.sp),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Text(
                    S.of(context).verificationCodeDescription,
                    textAlign: TextAlign.center,
                    style: TextStyles.regular14(context).copyWith(
                      color: const Color(0xFF4C4C4C),
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 32.sp),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double boxSize =
                          (constraints.maxWidth -
                                  (_digitCount - 1) * _boxSpacing) /
                              _digitCount;
                      return Row(
                        children: List.generate(
                          _digitCount,
                          (index) => Padding(
                            padding: EdgeInsets.only(
                              right: index < _digitCount - 1 ? _boxSpacing : 0,
                            ),
                            child: CustomPinBox(
                              size: boxSize,
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              onChanged: (value) {
                                if (value.isNotEmpty &&
                                    index < _digitCount - 1) {
                                  _focusNodes[index + 1].requestFocus();
                                } else if (value.isEmpty && index > 0) {
                                  _focusNodes[index - 1].requestFocus();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) return '';
                                return null;
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 32.sp),
                _isLoading
                    ? const CustomLoadingButton()
                    : CustomButton(
                        backgroundColor: AppColors.lightPrimaryColor,
                        textColor: AppColors.secondaryColor,
                        onPressed: _submit,
                        text: S.of(context).verify,
                      ),
                SizedBox(height: 24.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).dontReceiveCode,
                      style: TextStyles.regular14(context)
                          .copyWith(color: const Color(0xFF4C4C4C)),
                    ),
                    SizedBox(width: 4.sp),
                    GestureDetector(
                      onTap: _isLoading ? null : _resend,
                      child: Text(
                        S.of(context).resend,
                        style: TextStyles.semiBold14(context)
                            .copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
