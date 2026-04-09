import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/features/history/view/widgets/history_view_body.dart';
import 'package:safqaseller/features/history/view_model/history_view_model.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  static const String routeName = 'historyView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HistoryViewModel>()..loadPage(1),
      child: const HistoryViewBody(),
    );
  }
}
