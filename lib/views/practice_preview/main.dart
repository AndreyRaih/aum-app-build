import 'package:aum_app_build/views/practice_preview/components/description.dart';
import 'package:aum_app_build/views/practice_preview/components/image.dart';
import 'package:aum_app_build/views/practice_preview/components/preferences.dart';
import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/page.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              PreviewImg(),
              Positioned(
                  top: 24.0,
                  child: AumBackButton(onPressed: () {
                    Navigator.pop(context);
                  })),
            ]),
            Container(
                color: Colors.white,
                width: double.maxFinite,
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PreviewDescription(),
                    PreviewPreferences(),
                    AumPrimaryButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/feedback');
                      },
                      text: 'Start practice',
                    )
                  ],
                ))
          ],
        ),
        isFullscreen: true);
  }
}
