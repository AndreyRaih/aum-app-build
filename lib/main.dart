import 'package:aum_app_build/views/asana_details/main.dart';
import 'package:aum_app_build/views/feedback/main.dart';
import 'package:aum_app_build/views/progress/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/dashboard/main.dart';
import 'package:aum_app_build/views/practice_preview/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/preview': (context) => PreviewScreen(),
        '/progress': (context) => ProgressScreen(),
        '/asana-detail': (context) => AsanaDetailScreen(),
        '/feedback': (context) => FeedbackScreen()
      },
    );
  }
}
