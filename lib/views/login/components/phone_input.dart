import 'package:aum_app_build/views/login/bloc/login_bloc.dart';
import 'package:aum_app_build/views/login/bloc/login_event.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/input.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPhoneInput extends StatefulWidget {
  @override
  _LoginPhoneInputState createState() => _LoginPhoneInputState();
}

class _LoginPhoneInputState extends State<LoginPhoneInput> {
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return AumPage(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AumText.bold(
            'Sign in',
            size: 48,
          ),
          Container(
            width: 250,
            margin: EdgeInsets.only(top: 68, bottom: BIG_OFFSET),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: SMALL_OFFSET),
                  child: AumInput(
                    value: '+7 (___) __-__-__',
                    placeholder: 'Enter your phone number',
                    isCentered: true,
                    autofocus: true,
                    customFormatter: AumInputFormatters.phoneNumber,
                    onInput: (_val) => setState(() {
                      phoneNumber = _val;
                    }),
                  ),
                ),
                AumText.medium(
                  'Plese, enter your phone number',
                  color: AumColor.additional,
                  size: 14,
                ),
              ],
            ),
          ),
          AumPrimaryButton(
            onPressed: () => BlocProvider.of<LoginBloc>(context).add(LoginSignInVerifyPhone(phoneNumber)),
            text: 'Send code',
          )
        ],
      ),
    );
  }
}
