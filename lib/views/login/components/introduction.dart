import 'package:aum_app_build/views/alan_button/main.dart';
import 'package:aum_app_build/views/login/bloc/login_bloc.dart';
import 'package:aum_app_build/views/login/bloc/login_event.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginIntorduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AumText.bold(
            'Nice to meet you, {username}!',
            size: 36,
            align: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: MIDDLE_OFFSET),
            child: AumText.medium(
              'Lets introduce to Aum.\n Push the button with icon and say \n"Hello, Aum"',
              color: AumColor.additional,
              align: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: LARGE_OFFSET),
            child: AumAlanButton(),
          ),
          AumPrimaryButton(
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(LoginFinishedAumIntroduction());
            },
            text: 'Look feed',
          )
        ],
      ),
    );
  }
}
