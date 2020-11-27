import 'package:aum_app_build/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardFactComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_FactIcon(), _Fact()],
    );
  }
}

class _Fact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
      String fact = state is DashboardPreview ? state.fact : 'Loading...';
      return Flexible(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
        AumText.bold('Fun fact', size: 16.0),
        AumText.regular(
          fact,
          size: 14.0,
          color: AumColor.additional,
        )
      ]));
    });
  }
}

class _FactIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(color: AumColor.secondary, shape: BoxShape.circle),
      child: Center(
          child: Icon(
        AumIcon.info,
        color: AumColor.accent,
      )),
    );
  }
}
