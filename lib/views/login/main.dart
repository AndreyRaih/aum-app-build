import 'package:aum_app_build/views/login/bloc/login_bloc.dart';
import 'package:aum_app_build/views/login/bloc/login_state.dart';
import 'package:aum_app_build/views/login/components/code_input.dart';
import 'package:aum_app_build/views/login/components/introduction.dart';
import 'package:aum_app_build/views/login/components/initial.dart';
import 'package:aum_app_build/views/login/components/phone_input.dart';
import 'package:aum_app_build/views/login/components/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  Widget _renderContent(LoginState state) {
    if (state is LoginInitial) {
      return LoginInitialView();
    }
    if (state is LoginSignIn) {
      return state.phone == null ? LoginPhoneInput() : LoginCodeInput();
    }
    if (state is LoginSignUp) {
      return LoginProfileEditor();
    }
    if (state is LoginAumIntroduction) {
      return LoginIntorduction();
    }
    return LoginInitialView(error: (state as LoginFailure).error);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => _renderContent(state),
    );
  }
}
