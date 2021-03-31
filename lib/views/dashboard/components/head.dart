import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user/user_bloc.dart';
import 'package:aum_app_build/views/shared/card.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:aum_app_build/views/shared/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardHeadComponent extends StatelessWidget {
  Widget build(BuildContext context) {
    return AumCard(child: _Content());
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _greetingWidth = MediaQuery.of(context).size.width - 200;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<UserBloc, UserState>(builder: (BuildContext context, state) {
          if (state is UserSuccess) {
            String name = state.user.name != null ? state.user.name : 'user';
            String greeting = 'Hi, $name!';
            return Container(
                margin: EdgeInsets.all(MIDDLE_OFFSET),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(margin: EdgeInsets.only(right: 16.0), child: AumAvatar(uri: state.user.avatar)),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        AumText.bold(greeting, size: 32.0),
                        Container(
                            width: _greetingWidth,
                            margin: EdgeInsets.only(top: TINY_OFFSET),
                            child: AumSecondaryButton(
                              text: 'view Progress',
                              onPressed: () {
                                BlocProvider.of<NavigatorCubit>(context).navigatorPush('/progress');
                              },
                            ))
                      ])
                    ]));
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
