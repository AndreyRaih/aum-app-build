import 'package:aum_app_build/views/profile_editor/main.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            child: UserDataEditor(),
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
