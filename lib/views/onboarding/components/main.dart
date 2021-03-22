import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/widgets.dart';

class ConceptMainStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(margin: EdgeInsets.only(bottom: 16.0), child: Image.asset(ONBOARDING_MAIN_IMAGE)),
      Padding(padding: EdgeInsets.only(bottom: 8), child: AumText.bold("What is Aum?", size: 28)),
      Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: AumText.medium(
            "Hello, we are Yoga classes app with dynamic content feed system, which based on ML power.",
            size: 18,
            color: AumColor.additional,
            align: TextAlign.center,
          )),
    ]);
  }
}
