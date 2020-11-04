import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map preview = ModalRoute.of(context).settings.arguments;
    BlocProvider.of<PreviewBloc>(context).add(InitPreview(preview: preview));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewBloc, PreviewState>(builder: (context, state) {
      if (state is PreviewIsReady) {
        PracticePreferences _preferences = state.preferenceValues;
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
                            BlocProvider.of<NavigatorBloc>(context)
                                .add(NavigatorPop());
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
                            BlocProvider.of<NavigatorBloc>(context).add(
                                NavigatorPush(
                                    route: '/player', arguments: _preferences));
                          },
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
