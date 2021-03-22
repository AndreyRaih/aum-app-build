import 'package:aum_app_build/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardActualPeopleComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(color: AumColor.secondary, shape: BoxShape.circle),
        child: Center(
            child: Icon(
          AumIcon.group,
          color: AumColor.accent,
        )),
      ),
      _Message()
    ]);
  }
}

class _Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
      return Container(
          margin: EdgeInsets.only(left: 16.0),
          child: state is DashboardPreview
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  AumText.bold(
                    '${state.count.toString()} people practice with you',
                    size: 16.0,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 4.0),
                      child: AumText.regular(
                        'Here and now',
                        size: 14.0,
                        color: AumColor.additional,
                      )),
                ])
              : AumText.medium(
                  'Loading...',
                  size: 16.0,
                ));
    });
  }
}
