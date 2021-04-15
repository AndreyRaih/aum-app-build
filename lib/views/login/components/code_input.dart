import 'dart:ui';

import 'package:aum_app_build/views/login/bloc/login_bloc.dart';
import 'package:aum_app_build/views/login/bloc/login_event.dart';
import 'package:aum_app_build/views/login/bloc/login_state.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCodeInput extends StatefulWidget {
  @override
  _LoginCodeInputState createState() => _LoginCodeInputState();
}

class _LoginCodeInputState extends State<LoginCodeInput> {
  String smsCode;
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
            width: 280,
            margin: EdgeInsets.only(top: BIG_OFFSET, bottom: BIG_OFFSET),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: SMALL_OFFSET),
                    child: _CodeSymbolsInput(onChange: (_code) => setState(() => smsCode = _code))),
                AumText.medium(
                  'Plese, enter code from SMS',
                  color: AumColor.additional,
                  size: 14,
                ),
              ],
            ),
          ),
          AumPrimaryButton(
            onPressed: () {
              String _existNumber = (BlocProvider.of<LoginBloc>(context).state as LoginSignIn).phone;
              BlocProvider.of<LoginBloc>(context).add(LoginSignInVerifyPhone(_existNumber));
            },
            text: 'Send code again',
          )
        ],
      ),
    );
  }
}

class _CodeSymbolsInput extends StatefulWidget {
  Function(String) onChange;

  _CodeSymbolsInput({this.onChange});

  @override
  _CodeSymbolsInputState createState() => _CodeSymbolsInputState();
}

class _CodeSymbolsInputState extends State<_CodeSymbolsInput> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    List<Widget> _inputs = List(6)
        .map<Widget>((e) => Container(
              width: 36,
              height: 48,
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: CupertinoTextField(
                  selectionWidthStyle: BoxWidthStyle.tight,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, color: AumColor.additional),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  decoration: BoxDecoration(color: Colors.transparent),
                  cursorColor: AumColor.additional,
                  onChanged: (_val) => setState(() {
                    if (_val.length > 0) {
                      value = value + _val;
                      if (value.length == 6) {
                        BlocProvider.of<LoginBloc>(context).add(LoginSignInCodeSent(value));
                      } else {
                        FocusScope.of(context).nextFocus();
                      }
                    } else {
                      int stringLength = value.length - 1;
                      value = value.substring(0, stringLength);
                      FocusScope.of(context).previousFocus();
                    }
                  }),
                ),
              ),
            ))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _inputs,
    );
  }
}
