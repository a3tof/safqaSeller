import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/constants.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/widgets/custom_button.dart';
import 'package:safqaseller/core/widgets/custom_loading_button.dart';
import 'package:safqaseller/core/widgets/password_field.dart';
import 'package:safqaseller/features/auth/view/auth_route_args.dart';
import 'package:safqaseller/features/auth/view/signin_view.dart';
import 'package:safqaseller/generated/l10n.dart';

class CreatePasswordViewBody extends StatefulWidget {
  const CreatePasswordViewBody({super.key, required this.args});
  final CreatePasswordArgs args;

  @override
  State<CreatePasswordViewBody> createState() => _CreatePasswordViewBodyState();
}

class _CreatePasswordViewBodyState extends State<CreatePasswordViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late String _newPassword, _confirmPassword;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_newPassword != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).passwordsDoNotMatch),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(S.of(context).passwordResetSuccessfully),
      backgroundColor: Colors.green,
    ));
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninView.routeName,
      (route) => false,
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
            child: Column(
              children: [
                SizedBox(height: 16.sp),
                Text(
                  S.of(context).createPasswordDescription,
                  style: TextStyles.regular14(context).copyWith(
                    color: const Color(0xFF4C4C4C),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 32.sp),
                PasswordField(
                  enabled: !_isLoading,
                  controller: _passwordController,
                  hintText: S.of(context).newPassword,
                  onSaved: (value) => _newPassword = value ?? '',
                ),
                SizedBox(height: 32.sp),
                PasswordField(
                  enabled: !_isLoading,
                  hintText: S.of(context).confirmPassword,
                  onSaved: (value) => _confirmPassword = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).fieldRequired;
                    }
                    if (value != _passwordController.text) {
                      return S.of(context).passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.sp),
                _isLoading
                    ? const CustomLoadingButton()
                    : CustomButton(
                        onPressed: _submit,
                        text: S.of(context).createPassword,
                        textColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
