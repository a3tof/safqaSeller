import 'package:flutter/material.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/auth/view/auth_route_args.dart';
import 'package:safqaseller/features/auth/view/widgets/create_password_view_body.dart';
import 'package:safqaseller/generated/l10n.dart';

class CreatePasswordView extends StatelessWidget {
  const CreatePasswordView({super.key, required this.args});

  static const String routeName = 'createPassword';
  final CreatePasswordArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: S.of(context).createPassword,
      ),
      body: CreatePasswordViewBody(args: args),
    );
  }
}
