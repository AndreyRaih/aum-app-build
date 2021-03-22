import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/practice.dart';
import 'package:aum_app_build/views/shared/card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/data_row.dart';
import 'package:flutter/material.dart';

class DashboardPracticeComponent extends StatelessWidget {
  void _openPreview(BuildContext context) => BlocProvider.of<UserBloc>(context)
      .add(UserOnboardingRouteHook(onboardingTarget: UserOnboardingTarget.concept, route: PREVIEW_ROUTE_NAME));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      ImageProvider _img = (state is UserSuccess) ? state.personalSession.img : null;
      String _title = (state is UserSuccess) ? state.personalSession.name : null;
      return AumCard(
          isLoading: (state is UserLoading),
          image: _img,
          title: _title,
          content: _PracticeContent(),
          actions: AumPrimaryButton(text: 'Lets begin', onPressed: () => _openPreview(context)));
    });
  }
}

class _PracticeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AumUserPractice practice = (BlocProvider.of<UserBloc>(context).state as UserSuccess).personalSession;
    final List<Map<String, dynamic>> _items = [
      {'label': 'Time', 'value': '${(practice.time / 60).floor().toString()} min'},
      {'label': 'Calories', 'value': practice.cal.toString()},
      {'label': 'Includes', 'value': practice.accents.join(', ')}
    ];
    return AumDataRow(data: _items);
  }
}
