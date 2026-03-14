import 'package:flutter/material.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/auth/view/widgets/signin_view_body.dart';
import 'package:safqaseller/generated/l10n.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const String routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: S.of(context).signIn),
      body: const SigninViewBody(),
    );
  }
}
