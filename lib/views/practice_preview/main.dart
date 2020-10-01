import 'package:aum_app_build/data/models/preferences.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_bloc.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:aum_app_build/views/practice_preview/components/description.dart';
import 'package:aum_app_build/views/practice_preview/components/image.dart';
import 'package:aum_app_build/views/practice_preview/components/preferences.dart';
import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewBloc, PreviewState>(builder: (context, state) {
      PracticePreferences _preferences =
          (state as PreviewPreferencesIsReady).values;
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
                          Navigator.pushNamed(context, '/player',
                              arguments: _preferences);
                        },
                        text: 'Start practice',
                      )
                    ],
                  ))
            ],
          ),
          isFullscreen: true);
    });
  }
}
