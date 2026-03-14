import 'package:flutter/material.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/auth/view/auth_route_args.dart';
import 'package:safqaseller/features/auth/view/widgets/verification_code_view_body.dart';
import 'package:safqaseller/generated/l10n.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key, required this.args});

  static const String routeName = 'verificationCode';
  final VerificationCodeArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: S.of(context).verificationCode,
      ),
      body: VerificationCodeViewBody(args: args),
    );
  }
}
