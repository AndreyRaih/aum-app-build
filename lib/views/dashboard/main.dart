import 'package:aum_app_build/views/dashboard/components/facts.dart';
import 'package:aum_app_build/views/dashboard/components/practice.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/shared/segment.dart';
import 'package:aum_app_build/views/dashboard/components/head.dart';
import 'package:aum_app_build/views/dashboard/components/actual_people.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      AumSegment(child: DashboardHeadComponent()),
      AumSegment(
          child: DashboardActualPeopleComponent(), padding: EdgeInsets.all(16.0), margin: EdgeInsets.only(top: 24.0)),
      DashboardPracticeComponent(),
      AumSegment(child: DashboardFactComponent(), padding: EdgeInsets.all(16.0)),
    ]));
  }
}
