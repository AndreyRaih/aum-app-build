import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_bloc.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:aum_app_build/views/practice_preview/components/description.dart';
import 'package:aum_app_build/views/practice_preview/components/image.dart';
import 'package:aum_app_build/views/practice_preview/components/preferences.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  List<PracticePreferenceValue> _preferenceUpdates = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map preview = (BlocProvider.of<UserBloc>(context).state as UserSuccess).personalSession;
    BlocProvider.of<PreviewBloc>(context).add(InitPreview(preview: preview));
  }

  void _goToPractice(context) {
    PracticePreferences _preferences = (BlocProvider.of<PreviewBloc>(context).state as PreviewIsReady).preferenceValues;
    _preferenceUpdates.forEach((updates) => BlocProvider.of<PreviewBloc>(context).add(SetPreferences(updates: updates)));
    BlocProvider.of<UserBloc>(context)
        .add(UserOnboardingRouteHook(onboardingTarget: ONBOARDING_PLAYER_NAME, route: PLAYER_ROUTE_NAME, arguments: _preferences));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewBloc, PreviewState>(builder: (context, state) {
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
                            BlocProvider.of<NavigatorBloc>(context).add(NavigatorPop());
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
