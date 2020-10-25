import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/views/login/components/logo.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  final String type;
  LoginForm({this.type = 'signin'});
  Widget _renderForm() {
    switch (type) {
      case 'signin':
        return _SignInForm();
        break;
      case 'signup':
        return _SignUpForm();
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
              padding: EdgeInsets.symmetric(vertical: 48), child: _renderForm())
        ],
      );
    });
  }
}

class _SignInForm extends StatefulWidget {
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  String _email;
  String _password;

  void _checkValid() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AumInput(
              label: 'Email',
              placeholder: 'Enter email',
              type: TextInputType.emailAddress,
              onInput: (value) => setState(() => _email = value),
            )),
        Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AumInput(
              label: 'Password',
              placeholder: 'Enter password',
              type: TextInputType.visiblePassword,
              onInput: (value) => setState(() => _password = value),
            )),
        AumPrimaryButton(
            text: 'Sign In',
            onPressed: () => BlocProvider.of<UserBloc>(context)
                .add(SignIn(email: _email, password: _password)))
      ],
    );
  }
}

class _SignUpForm extends StatefulWidget {
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  String _email;
  String _password;
  String _name;

  void _checkValid() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AumInput(
              label: 'Email',
              placeholder: 'Enter email',
              type: TextInputType.emailAddress,
              onInput: (value) => setState(() => _email = value),
            )),
        Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AumInput(
              label: 'Password',
              placeholder: 'Enter password',
              type: TextInputType.visiblePassword,
              onInput: (value) => setState(() => _password = value),
            )),
        AumPrimaryButton(
            text: 'Sign Up',
            onPressed: () => BlocProvider.of<UserBloc>(context)
                .add(SignUp(email: _email, password: _password)))
      ],
    );
  }
}
