import 'package:aum_app_build/utils/pose_estimation.dart';
import 'package:aum_app_build/views/dashboard/components/facts.dart';
import 'package:aum_app_build/views/dashboard/components/practice.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/shared/segment.dart';
import 'package:aum_app_build/views/dashboard/components/head.dart';
import 'package:aum_app_build/views/dashboard/components/actual_people.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<PosePoint> points = [
    PosePoint({"score": 0.0, "x": 0.5, "y": 0.5, "part": "one"}),
    PosePoint({"score": 0.0, "x": 0.6, "y": 0.6, "part": "two"})
  ];

  @override
  Widget build(BuildContext context) {
    return AumPage(
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      AumSegment(child: DashboardHeadComponent()),
      AumSegment(child: DashboardActualPeopleComponent(), padding: EdgeInsets.all(16.0), margin: EdgeInsets.only(top: 24.0)),
      DashboardPracticeComponent(),
      AumSegment(child: DashboardFactComponent(), padding: EdgeInsets.all(16.0)),
    ]));
  }
}
