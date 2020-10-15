import 'package:aum_app_build/views/login/components/form.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

abstract class LoginFormModal {
  void displayBottomSheet(BuildContext context, String formType) {
    showCupertinoModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.8),
        context: context,
        builder: (ctx, scrollController) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            height: MediaQuery.of(context).size.height - 36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      AumIcon.cancel,
                      size: 36,
                      color: AumColor.accent,
                    )),
                Expanded(
                    child: LoginForm(
                  type: formType,
                ))
              ],
            ),
          );
        });
  }
}
