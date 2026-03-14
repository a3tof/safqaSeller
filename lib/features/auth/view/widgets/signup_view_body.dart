import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/constants.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/widgets/custom_button.dart';
import 'package:safqaseller/core/widgets/custom_loading_button.dart';
import 'package:safqaseller/core/widgets/custom_text_field.dart';
import 'package:safqaseller/core/widgets/date_picker_field.dart';
import 'package:safqaseller/core/widgets/gender_picker_field.dart';
import 'package:safqaseller/core/widgets/password_field.dart';
import 'package:safqaseller/features/auth/view/auth_route_args.dart';
import 'package:safqaseller/features/auth/view/verification_code_view.dart';
import 'package:safqaseller/features/auth/view/widgets/have_an_account_widget.dart';
import 'package:safqaseller/features/auth/view/widgets/terms_and_conditions.dart';
import 'package:safqaseller/generated/l10n.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;
  late String _email, _password;
  String? _birthdate;
  String? _gender;
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidateMode = AutovalidateMode.always);
      return;
    }
    _formKey.currentState!.save();

    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).termsAndConditions),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_birthdate == null || _gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).otpSentToEmail),
        backgroundColor: const Color(0xFF1A3A6B),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pushNamed(
      context,
      VerificationCodeView.routeName,
      arguments: VerificationCodeArgs(
        email: _email,
        password: _password,
        flow: VerificationFlow.registration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding.sp),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Column(
            children: [
              SizedBox(height: 24.sp),
              CustomTextFormField(
                enabled: !_isLoading,
                hintText: S.of(context).fullName,
                textInputType: TextInputType.name,
              ),
              SizedBox(height: 16.sp),
              CustomTextFormField(
                enabled: !_isLoading,
                onSaved: (value) => _email = value!,
                hintText: S.of(context).email,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.sp),
              CustomTextFormField(
                enabled: !_isLoading,
                hintText: S.of(context).phoneNumber,
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: 16.sp),
              DatePickerField(
                enabled: !_isLoading,
                hintText: S.of(context).birthdate,
                onSaved: (value) => _birthdate = value,
              ),
              SizedBox(height: 16.sp),
              GenderPickerField(
                enabled: !_isLoading,
                hintText: S.of(context).gender,
                maleText: S.of(context).male,
                femaleText: S.of(context).female,
                onSaved: (value) => _gender = value,
              ),
              SizedBox(height: 16.sp),
              PasswordField(
                enabled: !_isLoading,
                controller: _passwordController,
                hintText: S.of(context).password,
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 16.sp),
              PasswordField(
                enabled: !_isLoading,
                hintText: S.of(context).confirmPassword,
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
              SizedBox(height: 16.sp),
              TermsAndConditions(
                onChanged: (value) => _isTermsAccepted = value,
              ),
              SizedBox(height: 30.sp),
              _isLoading
                  ? const CustomLoadingButton()
                  : CustomButton(
                      backgroundColor: AppColors.lightPrimaryColor,
                      textColor: AppColors.secondaryColor,
                      onPressed: _submit,
                      text: S.of(context).signUp,
                    ),
              SizedBox(height: 26.sp),
              HaveAnAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
