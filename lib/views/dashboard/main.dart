import 'package:aum_app_build/views/alan_button/main.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_event.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';
import 'package:aum_app_build/views/dashboard/components/feed.dart';
import 'package:aum_app_build/views/dashboard/components/snippets.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/dashboard/components/head.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  Widget _defineDashboardView(DashboardState state, BuildContext context) {
    if (state is DashboardPreview) {
      DashboardViews _currentView = state.currentView;
      switch (_currentView) {
        case DashboardViews.initial:
          return ConstrainedBox(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 280), child: _InitialView());
        case DashboardViews.feed:
          return _FeedView();
        default:
          return _InitialView();
      }
    } else {
      return AumLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AumPage(child: BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
      if (state is DashboardLoading) {
        return AumLoader();
      }
      return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: DashboardHeadComponent()),
            _defineDashboardView(state, context)
          ]);
    }));
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
                          onPressed: () => BlocProvider.of<DashboardBloc>(context).add(DashboardGetTags()),
                          text: 'Show more',
                        ))))
          ]),
          Padding(padding: EdgeInsets.only(top: LARGE_OFFSET), child: AumAlanButton())
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
      Padding(
          padding: EdgeInsets.only(bottom: BIG_OFFSET),
          child: DashboardFeedComponent((BlocProvider.of<DashboardBloc>(context).state as DashboardPreview).mainFeed)),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              width: 220,
              child: AumText.bold(
                'Also, it might be of interest',
                size: 28,
              ))),
      DashboardFeedComponent((BlocProvider.of<DashboardBloc>(context).state as DashboardPreview).additionalFeed)
    ]);
  }
}
