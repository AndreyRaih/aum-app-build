import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/data_row.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class DashboardPracticeComponent extends StatelessWidget {
  void _openPreview(BuildContext context) =>
      BlocProvider.of<UserBloc>(context).add(UserOnboardingRouteHook(onboardingTarget: ONBOARDING_CONCEPT_NAME, route: PREVIEW_ROUTE_NAME));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoading) {
        return AumLoader();
      }
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _PracticeImage(),
        _PracticeTitle(),
        _PracticeShortInfo(),
        AumPrimaryButton(
          onPressed: () => _openPreview(context),
          text: 'Lets begin',
        )
      ]);
    });
  }
}

class _PracticeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 200, margin: EdgeInsets.only(bottom: 16.0), child: Image.asset('img/dashboard_2.png'));
  }
}

class _PracticeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = (BlocProvider.of<UserBloc>(context).state as UserSuccess).personalSession.name;
    return Container(margin: EdgeInsets.only(bottom: 8.0), child: AumText.bold(name, size: 30.0));
  }
}

class _PracticeShortInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AumUserPractice practice = (BlocProvider.of<UserBloc>(context).state as UserSuccess).personalSession;
    final List<Map<String, dynamic>> _items = [
      {'label': 'Time', 'value': '${(practice.time / 60).floor().toString()} min'},
      {'label': 'Calories', 'value': practice.cal.toString()},
      {'label': 'Includes', 'value': practice.accents.join(', ')}
    ];
    return Container(margin: EdgeInsets.only(bottom: 24.0), child: AumDataRow(data: _items));
  }
}
