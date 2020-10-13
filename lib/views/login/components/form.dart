import 'package:aum_app_build/views/login/components/logo.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/input.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final String type;
  LoginForm({this.type = 'signin'});
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String getActionName() => widget.type == 'signin' ? 'Sign In' : 'Register';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(bottom: 48), child: LoginLogo()),
        Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AumInput(
              label: 'Email',
              type: TextInputType.emailAddress,
              placeholder: 'Enter your email',
            )),
        Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AumInput(
              label: 'Password',
              type: TextInputType.visiblePassword,
              placeholder: 'Enter your password',
            )),
        Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: AumPrimaryButton(text: getActionName(), onPressed: null)),
        AumText.medium(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          align: TextAlign.center,
          size: 16,
          color: AumColor.additional,
        )
      ],
    );
  }
}
