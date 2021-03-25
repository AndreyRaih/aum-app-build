import 'package:aum_app_build/views/dashboard/components/feed.dart';
import 'package:aum_app_build/views/dashboard/components/snippets.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/dashboard/components/head.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: DashboardHeadComponent()),
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 280),
              // TODO: Change conditions
              child: 0 > 1 ? _FeedView() : _InitialView())
        ]));
  }
}

class _InitialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                    padding: EdgeInsets.only(top: MIDDLE_OFFSET),
                    child: AumText.bold(
                      'What do you want for now?',
                      size: 36,
                    ))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: SMALL_OFFSET), child: DashboardSnippetsView()),
            Padding(
                padding: EdgeInsets.only(top: MIDDLE_OFFSET),
                child: Center(
                    child: Container(
                        width: 200,
                        child: AumPrimaryButton(
                          onPressed: () {},
                          text: 'Show more',
                        ))))
          ]),
          Center(
              child: Container(
                  width: 120, height: 120, decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle)))
        ]);
  }
}

class _FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
              padding: EdgeInsets.only(top: MIDDLE_OFFSET),
              child: AumText.bold(
                'Just only for you, Andrew',
                size: 36,
              ))),
      Padding(padding: EdgeInsets.only(bottom: BIG_OFFSET), child: DashboardFeedComponent()),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              width: 220,
              child: AumText.bold(
                'Also, it might be of interest',
                size: 28,
              ))),
      DashboardFeedComponent()
    ]);
  }
}
