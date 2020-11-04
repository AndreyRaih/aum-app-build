import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:aum_app_build/views/shared/palette.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<UserBloc, UserState>(
            builder: (BuildContext context, state) {
          String name = state is UserIsDefined ? state.user.name : null;
          String greeting = 'Hi,' + (name != null ? ' $name!' : '!');
          return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                margin: EdgeInsets.only(right: 16.0),
                child: AumAvatar(
                    uri:
                        'https://semantic-ui.com/images/avatar2/large/matthew.png')),
            AumText.bold(greeting, size: 32.0)
          ]);
        }),
        Icon(
          AumIcon.notification_icon,
          color: AumColor.additional,
          size: 26.0,
        )
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
            BlocProvider.of<NavigatorBloc>(context)
                .add(NavigatorPush(route: '/progress'));
          },
        ));
  }
}
