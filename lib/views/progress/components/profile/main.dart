import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/progress/components/profile/editor.dart';
import 'package:aum_app_build/views/shared/avatar.dart';
import 'package:aum_app_build/views/shared/card.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class ProgressProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumCard(
      child: Container(
        margin: EdgeInsets.all(MIDDLE_OFFSET),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(margin: EdgeInsets.only(right: 16.0), child: AumAvatar(uri: DEFAULT_AVATAR_IMG)),
            Container(
              width: MediaQuery.of(context).size.width - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [AumText.bold('Andrew', size: 32.0), ProgressProfileEditor()],
                  ),
                  Wrap(children: [
                    AumText.medium(
                      'Interests: ',
                      color: AumColor.additional,
                    ),
                    AumText.bold(
                      'mindfulness, balances, ashtagna',
                      color: AumColor.accent,
                    )
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
