import 'package:aum_app_build/views/login/components/form.dart';
import 'package:aum_app_build/views/login/components/logo.dart';
import 'package:aum_app_build/views/login/components/modal.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LoginActions extends StatefulWidget {
  @override
  _LoginActionsState createState() => _LoginActionsState();
}

class _LoginActionsState extends State<LoginActions> with LoginFormModal {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AumPrimaryButton(
                text: 'Sign in with Google',
                onPressed: () {
                  displayBottomSheet(context, 'signin');
                })),
        Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: AumOutlineButton(
                text: 'or Sign in with email',
                onPressed: () {
                  displayBottomSheet(context, 'signin');
                })),
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
                onTap: () {
                  displayBottomSheet(context, 'register');
                },
                child: AumText.bold("Please, register",
                    align: TextAlign.center, size: 18, color: AumColor.accent))
          ],
        )
      ],
    );
  }
}
