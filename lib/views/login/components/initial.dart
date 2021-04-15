import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/login/bloc/login_bloc.dart';
import 'package:aum_app_build/views/login/bloc/login_event.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginInitialView extends StatelessWidget {
  String error;

  LoginInitialView({this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        image: DecorationImage(
          image: AssetImage(MAIN_BACKGROUND_IMAGE),
          alignment: Alignment(-0.5, 0),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(48),
        color: Colors.white24.withOpacity(0.8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: BIG_OFFSET),
                child: Container(
                  width: 160,
                  height: 160,
                  margin: EdgeInsets.only(bottom: 24),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage(LOGO_IMAGE))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MINI_OFFSET),
                child: AumText.bold(
                  'Aum',
                  size: 36,
                  align: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: BIG_OFFSET),
                child: AumText.medium(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  size: 16,
                  color: AumColor.additional,
                  align: TextAlign.center,
                ),
              ),
              AumPrimaryButton(
                onPressed: () => BlocProvider.of<LoginBloc>(context).add(LoginSignInInit()),
                text: 'Sign in',
              )
            ],
          ),
        ),
      ),
    );
  }
}
