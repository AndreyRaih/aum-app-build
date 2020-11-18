import 'package:aum_app_build/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:aum_app_build/views/shared/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardActualPeopleComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[_AvatarGroup(), _Message()]);
  }
}

class _AvatarGroup extends StatelessWidget {
  Widget _getAvatarMiniature(String uri) {
    return Container(
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            color: Color(0xFFEEF7FE), borderRadius: BorderRadius.circular(48)),
        child: AumAvatar(uri: uri, size: 18.0));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(overflow: Overflow.visible, children: <Widget>[
      AumAvatar(
          uri:
              'https://i.pinimg.com/736x/46/a4/2e/46a42ec536aba119386fadacc1b00e73.jpg'),
      Positioned(
          bottom: -4,
          right: 0,
          child: _getAvatarMiniature(
              'https://networthpost.org/wp-content/uploads/2018/02/Roll-Safe-Net-Worth.jpg')),
      Positioned(
          bottom: -4,
          right: 4,
          child: _getAvatarMiniature(
              'https://i.pinimg.com/736x/36/49/f0/3649f0878034f82e578df692587dd452.jpg')),
    ]);
  }
}

class _Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      return Container(
          margin: EdgeInsets.only(left: 16.0),
          child: state is DashboardPreview
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      AumText.bold(
                        '${state.count.toString()} people practice with you now',
                        size: 16.0,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 4.0),
                          child: AumText.regular(
                            'From: Penza, Moscow',
                            size: 14.0,
                            color: AumColor.additional,
                          )),
                    ])
              : AumText('No one...'));
    });
  }
}
