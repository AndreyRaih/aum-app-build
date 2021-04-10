import 'dart:io';

import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/input.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/shadows.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProgressProfileEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => showCupertinoModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.2),
        context: context,
        builder: (ctx, scrollController) {
          return Container(
            height: MediaQuery.of(context).size.height - 132.5,
            padding: EdgeInsets.symmetric(vertical: 40),
            child: _EditForm(),
          );
        },
      ),
      constraints: BoxConstraints(minWidth: 48, minHeight: 48),
      child: Center(
        child: Icon(
          AumIcon.edit,
          size: 32,
          color: AumColor.additional,
        ),
      ),
      shape: CircleBorder(),
    );
  }
}

class _EditForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AumText.bold(
          'Update your profile',
          size: 36,
        ),
        _EditControlls(),
        AumPrimaryButton(
          onPressed: () {},
          text: 'Update profile',
        ),
      ],
    );
  }
}

class _EditControlls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FormAvatarLoader(),
        Container(
          width: 250,
          margin: EdgeInsets.only(top: BIG_OFFSET),
          child: AumInput(
            placeholder: 'Andrew',
            isCentered: true,
          ),
        ),
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
                    'mindfulness, balances, ashtagna',
                    color: AumColor.accent,
                    align: TextAlign.center,
                  )
                ])),
        AumOutlineButton(
          onPressed: () {},
          text: 'Clear',
        )
      ],
    );
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
    return GestureDetector(
        onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () => getImage(ImageSource.camera),
                    child: Text('Make a photo'),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () => getImage(ImageSource.gallery),
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
                  image: _image == null ? NetworkImage(DEFAULT_AVATAR_IMG) : FileImage(_image),
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
        ));
  }
}
