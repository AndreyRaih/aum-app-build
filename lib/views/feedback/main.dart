import 'package:aum_app_build/views/alan_button/main.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/stepper.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
      isFullscreen: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Container(
          height: MediaQuery.of(context).size.height - 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Center(
                        child: AumText.bold(
                          'Did feel you a pain during seating in Lotus pose?',
                          size: 28,
                          align: TextAlign.center,
                        ),
                      ),
                    ),
                    Flexible(flex: 6, child: AumAlanButton()),
                    Flexible(
                      flex: 2,
                      child: AumOutlineButton(
                        onPressed: () {},
                        text: 'Go to next',
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AumIndicatorsDots(
                      step: 0,
                      steps: 3,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MIDDLE_OFFSET),
                      width: 220,
                      child: AumPrimaryButton(
                        onPressed: () {},
                        text: 'Finish practice',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
