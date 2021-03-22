import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:aum_app_build/views/shared/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardHeadComponent extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_InfoRow(), _ExploreViewControll()],
    );
  }
}

class _InfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _greetingWidth = MediaQuery.of(context).size.width - 150;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<UserBloc, UserState>(builder: (BuildContext context, state) {
          if (state is UserSuccess) {
            String name = state.user.name != null ? state.user.name : 'user';
            String greeting = 'Hi, $name!';
            return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(margin: EdgeInsets.only(right: 16.0), child: AumAvatar(uri: state.avatarUrl)),
              Container(width: _greetingWidth, child: AumText.bold(greeting, size: 32.0))
            ]);
          }
          if (state is UserLoading) {
            return AumLoader(
              centered: false,
            );
          }
          return Container();
        })
      ],
    );
  }
}

class _ExploreViewControll extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        child: AumSecondaryButton(
          text: 'explore your practice',
          onPressed: () {
            BlocProvider.of<NavigatorBloc>(context).add(NavigatorPush(route: '/progress'));
          },
        ));
  }
}
