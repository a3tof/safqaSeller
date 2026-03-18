import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/auth/view/widgets/signin_view_body.dart';
import 'package:safqaseller/features/auth/view_model/login/login_view_model.dart';
import 'package:safqaseller/generated/l10n.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const String routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginViewModel>(),
      child: Scaffold(
        appBar: buildAppBar(context: context, title: S.of(context).signIn),
        body: const SigninViewBody(),
      ),
    );
  }
}
