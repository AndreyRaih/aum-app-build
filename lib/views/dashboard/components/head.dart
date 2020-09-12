import 'package:flutter/material.dart';
import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/avatar.dart';

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
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              margin: EdgeInsets.only(right: 16.0),
              child: AumAvatar(
                  uri:
                      'https://semantic-ui.com/images/avatar2/large/matthew.png')),
          AumText.bold('Hi, Andrew!', size: 32.0)
        ]),
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
          onPressed: () {},
        ));
  }
}
