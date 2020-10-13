import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/data_row.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class DashboardPracticeComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _PracticeImage(),
      _PracticeTitle(),
      _PracticeShortInfo(),
      AumPrimaryButton(
        onPressed: () {
          BlocProvider.of<NavigatorBloc>(context)
              .add(NavigatorPush(route: '/preview'));
        },
        text: 'Lets begin',
      )
    ]);
  }
}

class _PracticeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Image.asset('img/dashboard_2.png'));
  }
}

class _PracticeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 8.0),
        child: AumText.bold('Stress relief practice', size: 30.0));
  }
}

class _PracticeShortInfo extends StatelessWidget {
  final List<Map<String, dynamic>> _items = [
    {'label': 'Time', 'value': '34 m'},
    {'label': 'Calories', 'value': '326'},
    {'label': 'Includes', 'value': 'Balances, standing'}
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 24.0), child: AumDataRow(data: _items));
  }
}
