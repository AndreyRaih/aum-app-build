import 'package:aum_app_build/views/player/components/controlls.dart';
import 'package:aum_app_build/views/player/components/video.dart';
import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.landscape
          ? Stack(children: [
              PlayerVideo(),
              PlayerAsanaPresentor(
                name: 'utthita trikoṇāsana',
                position: 2,
                practiceLength: 6,
              ),
              PlayerTimer(),
              PlayerControllButton(icon: AumIcon.cancel),
              PlayerControllButton(icon: AumIcon.audion_controll),
              PlayerMainControlls.leftControll(
                onControllTap: () {},
              ),
              PlayerMainControlls.rightControll(
                onControllTap: () {},
              )
            ])
          : Center(
              child: AumText('Please turn your phone in lanscape orientation'),
            );
    });
  }
}

class _PlayerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
