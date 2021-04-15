import 'dart:io';

import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/common_bloc/user/user_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/user.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/input.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/shadows.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserDataEditor extends StatefulWidget {
  Function onUpdate;

  UserDataEditor({this.onUpdate});

  @override
  _UserDataEditorState createState() => _UserDataEditorState();
}

class _UserDataEditorState extends State<UserDataEditor> {
  AumUserUpdatesModel _updates;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AumText.bold(
          'Update your profile',
          size: 36,
        ),
        _EditControlls(onUpdate: (value) => setState(() => _updates = value)),
        AumPrimaryButton(
          onPressed: () {
            BlocProvider.of<UserBloc>(context).add(UpdateUserModel(_updates));
            BlocProvider.of<NavigatorCubit>(context).navigatorPop();
            if (widget.onUpdate != null) {
              widget.onUpdate();
            }
          },
          text: 'Update profile',
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _EditControlls extends StatefulWidget {
  final Function(AumUserUpdatesModel) onUpdate;

  _EditControlls({this.onUpdate});

  @override
  _EditControllsState createState() => _EditControllsState();
}

class _EditControllsState extends State<_EditControlls> {
  AumUser _userData;
  AumUserUpdatesModel _updates;

  @override
  void didChangeDependencies() {
    setState(() {
      _userData = (BlocProvider.of<UserBloc>(context).state as UserSuccess).user;
      _updates = AumUserUpdatesModel(name: _userData != null ? _userData.name : null);
    });
    super.didChangeDependencies();
  }

  void _changeUserAvatar(File file) {
    setState(() {
      _updates.avatarURL = file.path;
    });
    widget.onUpdate(_updates);
  }

  void _changeUserName(String name) {
    setState(() {
      _updates.name = null;
    });
    widget.onUpdate(_updates);
  }

  void _clearRecentTags() {
    setState(() {
      _userData.recent = null;
      _updates.actual = [];
    });
    widget.onUpdate(_updates);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _recentTagsView = _userData != null && _userData.recent != null
        ? [
            Container(
              width: 210,
              padding: EdgeInsets.all(MIDDLE_OFFSET),
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  AumText.medium(
                    'Interests: ',
                    color: AumColor.additional,
                  ),
                  AumText.bold(
                    _userData.recent.join(', '),
                    color: AumColor.accent,
                    align: TextAlign.center,
                  )
                ],
              ),
            ),
            AumOutlineButton(
              onPressed: _clearRecentTags,
              text: 'Clear',
            )
          ]
        : [Container()];

    return Column(
      children: [
        _FormAvatarLoader(
          imageUrl: _userData != null ? _userData.avatar : DEFAULT_AVATAR_IMG,
          onSetImage: (_file) => _changeUserAvatar(_file),
        ),
        Container(
          width: 250,
          margin: EdgeInsets.only(top: BIG_OFFSET),
          child: AumInput(
            placeholder: 'Enter user name',
            isCentered: true,
            value: _userData != null ? _userData.name : null,
            onInput: (_value) => _changeUserName(_value),
          ),
        ),
        ..._recentTagsView
      ],
    );
  }
}

class _FormAvatarLoader extends StatefulWidget {
  final Function(File) onSetImage;
  final String imageUrl;
  const _FormAvatarLoader({this.onSetImage, this.imageUrl = DEFAULT_AVATAR_IMG});
  @override
  _FormAvatarLoaderState createState() => _FormAvatarLoaderState();
}

class _FormAvatarLoaderState extends State<_FormAvatarLoader> {
  File _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource source, BuildContext context) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.onSetImage(_image);
      } else {
        print('No image selected.');
      }
    });
    BlocProvider.of<NavigatorCubit>(context).navigatorPop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => getImage(ImageSource.camera, context),
              child: Text('Make a photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => getImage(ImageSource.gallery, context),
              child: Text('Select image from device'),
            ),
          ],
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: AumShadow.secondary,
              color: Colors.white.withOpacity(0.5),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: _image == null ? NetworkImage(widget.imageUrl) : FileImage(_image),
              ),
            ),
          ),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5),
            ),
            child: Center(
              child: Icon(
                AumIcon.photo,
                color: AumColor.accent,
                size: 64,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
