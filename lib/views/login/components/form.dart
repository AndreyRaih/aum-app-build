import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/views/login/components/logo.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/input.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final String type;
  LoginForm({this.type = 'signin'});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email;
  String _password;
  bool _emailIsInvalid = false;
  bool _passwordIsInvalid = false;

  Future _checkValid() {
    return Future(() {
      bool _emailValidationRule = _email != null && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);

      bool _passwordValidationRule = _password != null && _password.length > 4;
      setState(() {
        _emailIsInvalid = !_emailValidationRule;
        _passwordIsInvalid = !_passwordValidationRule;
      });
    });
  }

  void _formAction() async {
    await _checkValid();
    if (!_emailIsInvalid && !_passwordIsInvalid) {
      switch (widget.type) {
        case 'signin':
          return BlocProvider.of<UserBloc>(context).add(UserSignIn(email: _email, password: _password));
          break;
        case 'signup':
          return BlocProvider.of<UserBloc>(context).add(UserSignUp(email: _email, password: _password));
          break;
      }
    }
  }

  String _renderActionName() {
    switch (widget.type) {
      case 'signin':
        return 'Sign In';
        break;
      case 'signup':
        return 'Sign Up';
        break;
      default:
        return 'Sign In';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return Column(
        children: [
          LoginLogo(),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: AumInput(
                label: 'Email',
                hasError: _emailIsInvalid,
                errorMsg: 'Email is invalid',
                placeholder: 'Enter email',
                type: TextInputType.emailAddress,
                onInput: (value) => setState(() => _email = value),
              )),
          Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: AumInput(
                label: 'Password',
                placeholder: 'Enter password',
                hasError: _passwordIsInvalid,
                errorMsg: 'Password should be longer\nthen 4 chars. Try again',
                hideText: true,
                type: TextInputType.visiblePassword,
                onInput: (value) => setState(() => _password = value),
              )),
          (state is UserLoading) ? AumLoader() : AumPrimaryButton(text: _renderActionName(), onPressed: () => _formAction()),
          (state is UserFailure) && widget.type == 'signin'
              ? Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: AumText.medium(
                    "User don't exist.",
                    color: Colors.red[300],
                    align: TextAlign.center,
                  ))
              : Container()
        ],
      );
    });
  }
}
