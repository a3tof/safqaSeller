import 'package:flutter/material.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/auth/view/widgets/forget_password_view_body.dart';
import 'package:safqaseller/generated/l10n.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  static const String routeName = 'forgotPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: S.of(context).forgetPasswordTitle,
      ),
      body: const ForgotPasswordViewBody(),
    );
  }
}
