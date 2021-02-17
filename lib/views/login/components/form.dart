import 'dart:io';

import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/views/login/components/actions.dart';
import 'package:aum_app_build/views/login/components/logo.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/input.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class LoginForm extends StatefulWidget {
  final String type;
  LoginForm({this.type = SIGN_IN_ACTION});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  void _signIn(AumUserCreateModel data) => BlocProvider.of<UserBloc>(context).add(UserSignIn(data));

  void _signUp(AumUserCreateModel data) => BlocProvider.of<UserBloc>(context).add(UserSignUp(data));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      String _errorMessage =
          widget.type == SIGN_IN_ACTION ? "User don't exist" : "Something went wrong, let's try again";
      Widget _errorWidget = (state is UserFailure)
          ? Padding(
              padding: EdgeInsets.only(top: 16),
              child: AumText.medium(
                _errorMessage,
                color: Colors.red[300],
                align: TextAlign.center,
              ))
          : Container();
      Widget _signInForm = _SignInForm(
        onComplete: (data) => _signIn(data),
        isLoading: (state is UserLoading),
      );
      Widget _signUpForm = _SignUpForm(
        onComplete: (data) => _signUp(data),
        isLoading: (state is UserLoading),
      );
      Widget _form = widget.type == SIGN_IN_ACTION ? _signInForm : _signUpForm;
      return Column(
        children: [_form, _errorWidget],
      );
    });
  }
}

class _SignInForm extends StatefulWidget {
  final bool isLoading;
  final Function(AumUserCreateModel) onComplete;
  const _SignInForm({this.onComplete, this.isLoading});
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  String _email;
  String _password;
  bool _emailIsInvalid = false;
  bool _passwordIsInvalid = false;

  Future _checkValid() {
    return Future(() {
      bool _emailValidationRule = _email != null &&
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);

      bool _passwordValidationRule = _password != null && _password.length > 4;

      setState(() {
        _emailIsInvalid = !_emailValidationRule;
        _passwordIsInvalid = !_passwordValidationRule;
      });
    });
  }

  void _completeForm() async {
    await _checkValid();
    if (!_emailIsInvalid && !_passwordIsInvalid) {
      AumUserCreateModel _formData = AumUserCreateModel(email: _email, password: _password);
      widget.onComplete(_formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      widget.isLoading ? AumLoader() : AumPrimaryButton(text: "Sign In", onPressed: () => _completeForm()),
    ]);
  }
}

class _SignUpForm extends StatefulWidget {
  final bool isLoading;
  final Function(AumUserCreateModel) onComplete;
  const _SignUpForm({this.onComplete, this.isLoading});
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  File _avatar;
  String _email;
  String _password;
  String _name;
  bool _emailIsInvalid = false;
  bool _passwordIsInvalid = false;
  bool _nameIsInvalid = false;

  Future _checkValid() {
    return Future(() {
      bool _emailValidationRule = _email != null &&
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);

      bool _passwordValidationRule = _password != null && _password.length > 4;

      bool _nameValidationRule = _name != null;
      setState(() {
        _emailIsInvalid = !_emailValidationRule;
        _passwordIsInvalid = !_passwordValidationRule;
        _nameIsInvalid = !_nameValidationRule;
      });
    });
  }

  void _completeForm() async {
    await _checkValid();
    if (!_emailIsInvalid && !_passwordIsInvalid && !_nameIsInvalid) {
      AumUserCreateModel _formData =
          AumUserCreateModel(email: _email, password: _password, name: _name, avatar: _avatar);
      widget.onComplete(_formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _FormAvatarLoader(
        onSetImage: (image) => setState(() => _avatar = image),
      ),
      Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: AumInput(
            label: 'Name',
            placeholder: 'Enter your name',
            hasError: _nameIsInvalid,
            errorMsg: 'Name is invalid',
            type: TextInputType.text,
            onInput: (value) => setState(() => _name = value),
          )),
      Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: AumInput(
            label: 'Email',
            hasError: _emailIsInvalid,
            errorMsg: 'Email is invalid',
            placeholder: 'Enter email',
            type: TextInputType.emailAddress,
            onInput: (value) => setState(() => _email = value),
          )),
      Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: AumInput(
            label: 'Password',
            placeholder: 'Enter password',
            hasError: _passwordIsInvalid,
            errorMsg: 'Password should be longer\nthen 4 chars. Try again',
            hideText: true,
            type: TextInputType.visiblePassword,
            onInput: (value) => setState(() => _password = value),
          )),
      widget.isLoading ? AumLoader() : AumPrimaryButton(text: "Sign up", onPressed: () => _completeForm()),
    ]);
  }
}

class _FormAvatarLoader extends StatefulWidget {
  final Function(File) onSetImage;
  const _FormAvatarLoader({this.onSetImage});
  @override
  __FormAvatarLoaderState createState() => __FormAvatarLoaderState();
}

class __FormAvatarLoaderState extends State<_FormAvatarLoader> {
  File _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.onSetImage(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _emptyContainer = Container(
        width: 160,
        height: 160,
        margin: EdgeInsets.only(bottom: 48),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AumColor.secondary, width: 1)),
        child: Center(
          child: Icon(
            AumIcon.photo,
            color: AumColor.accent,
            size: 48,
          ),
        ));
    Widget _imageContainer = Container(
      width: 160,
      height: 160,
      margin: EdgeInsets.only(bottom: 48),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.fill, image: _image == null ? NetworkImage(DEFAULT_AVATAR_IMG) : FileImage(_image))),
    );
    return GestureDetector(
        onTap: () => showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
                  actions: [
                    CupertinoActionSheetAction(
                        onPressed: () => getImage(ImageSource.camera), child: Text('Make a photo')),
                    CupertinoActionSheetAction(
                        onPressed: () => getImage(ImageSource.gallery), child: Text('Select image from device')),
                  ],
                )),
        child: _image == null ? _emptyContainer : _imageContainer);
  }
}
