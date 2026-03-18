import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/auth/view/auth_route_args.dart';
import 'package:safqaseller/features/auth/view/widgets/verification_code_view_body.dart';
import 'package:safqaseller/features/auth/view_model/confirm_email/confirm_email_view_model.dart';
import 'package:safqaseller/features/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:safqaseller/generated/l10n.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key, required this.args});

  static const String routeName = 'verificationCode';
  final VerificationCodeArgs args;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: buildAppBar(
        context: context,
        title: S.of(context).verificationCode,
      ),
      body: VerificationCodeViewBody(args: args),
    );

    if (args.flow == VerificationFlow.registration) {
      return BlocProvider(
        create: (_) => getIt<ConfirmEmailViewModel>(),
        child: scaffold,
      );
    } else {
      // Thread the same ForgotPasswordViewModel instance from ForgotPasswordView.
      return BlocProvider.value(
        value: args.forgotPasswordViewModel ?? getIt<ForgotPasswordViewModel>(),
        child: scaffold,
      );
    }
  }
}
