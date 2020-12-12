import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/widgets.dart';

class ConceptHowItWorksStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(margin: EdgeInsets.only(bottom: 16.0), child: Image.asset('img/illustrations/concept_2.png')),
      Padding(padding: EdgeInsets.only(bottom: 8), child: AumText.bold("Practice first", size: 28)),
      Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: AumText.medium(
            "We believe that personal practice is a main attention point.",
            size: 18,
            color: AumColor.additional,
            align: TextAlign.center,
          )),
      Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: AumText.medium(
            "Just concentrate on exercises, while AumApp is analysing your progress and editing your personal practice",
            size: 18,
            color: AumColor.additional,
            align: TextAlign.center,
          )),
    ]);
  }
}
