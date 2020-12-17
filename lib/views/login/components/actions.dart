import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String SIGN_IN_ACTION = "signin";
const String SIGN_UP_ACTION = "signup";

class LoginActions extends StatelessWidget {
  final Function onCallForm;
  LoginActions({this.onCallForm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(bottom: 16), child: AumPrimaryButton(text: 'Sign in with email', onPressed: () => onCallForm(SIGN_IN_ACTION))),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AumText.medium(
              "Don't have an account?",
              align: TextAlign.center,
              size: 18,
              color: AumColor.additional,
            ),
            GestureDetector(
                onTap: () => onCallForm(SIGN_UP_ACTION), child: AumText.bold("Please, sign up", align: TextAlign.center, size: 18, color: AumColor.accent))
          ],
        )
      ],
    );
  }
}
