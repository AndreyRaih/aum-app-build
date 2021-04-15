import 'package:aum_app_build/views/login/bloc/login_bloc.dart';
import 'package:aum_app_build/views/login/bloc/login_event.dart';
import 'package:aum_app_build/views/profile_editor/main.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginProfileEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
      child: Center(
        child: Container(
          height: 500,
          child: UserDataEditor(
            onUpdate: () => BlocProvider.of<LoginBloc>(context).add(LoginUserProfileUpdated()),
          ),
        ),
      ),
    );
  }
}
