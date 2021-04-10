import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressProfileNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {},
              child: Text('Never'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {},
              child: Text('Often'),
            ),
          ],
        ),
      ),
      constraints: BoxConstraints(minWidth: 48, minHeight: 48),
      child: Center(
        child: Icon(
          AumIcon.notification_icon,
          color: AumColor.accent,
          size: 36,
        ),
      ),
      shape: CircleBorder(),
    );
  }
}
