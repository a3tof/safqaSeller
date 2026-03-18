import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/auth/view/widgets/signup_view_body.dart';
import 'package:safqaseller/features/auth/view_model/register/register_view_model.dart';
import 'package:safqaseller/generated/l10n.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const String routeName = 'signup';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterViewModel>(),
      child: Scaffold(
        appBar: buildAppBar(context: context, title: S.of(context).signUp),
        body: const SignupViewBody(),
      ),
    );
  }
}
