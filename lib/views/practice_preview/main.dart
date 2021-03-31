import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/common_bloc/onboarding/onboarding_state.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/practice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_cubit.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:aum_app_build/views/practice_preview/components/description.dart';
import 'package:aum_app_build/views/practice_preview/components/image.dart';
import 'package:aum_app_build/views/practice_preview/components/preferences.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  final AumUserPractice practice;

  PreviewScreen(this.practice);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  List<PracticePreferenceChanges> _preferenceUpdates = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PreviewCubit>(context).initPreview(widget.practice);
  }

  void _goToPractice(context) {
    PracticePreferences _preferences =
        (BlocProvider.of<PreviewCubit>(context).state as PreviewIsReady).preferenceValues;
    _preferenceUpdates.forEach((updates) => BlocProvider.of<PreviewCubit>(context).setPreferences(updates));
    AumPracticePlayerData _playerData = AumPracticePlayerData(widget.practice, preferences: _preferences);
    BlocProvider.of<NavigatorCubit>(context).createOnboardingRouteHook(
      PLAYER_ROUTE_NAME,
      OnboardingTarget.player,
      arguments: _playerData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewCubit, PreviewState>(builder: (context, state) {
      if (state is PreviewIsReady) {
        return AumPage(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  PreviewImg(),
                  Positioned(
                      top: 24.0,
                      left: 24,
                      child: AumBackButton(
                          text: 'Dashboard',
                          onPressed: () {
                            BlocProvider.of<NavigatorCubit>(context).navigatorPop();
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
                        PreviewPreferences(onUpdatePreferences: (updates) => _preferenceUpdates.add(updates)),
                        AumPrimaryButton(
                          onPressed: () => _goToPractice(context),
                          text: 'Start practice',
                        )
                      ],
                    ))
              ],
            ),
            isFullscreen: true);
      } else {
        return Container();
      }
    });
  }
}
