import 'package:aum_app_build/views/progress/components/advice_views/main.dart';
import 'package:aum_app_build/views/progress/components/date_select.dart';
import 'package:aum_app_build/views/progress/components/progress_view_changer.dart';
import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/page.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/segment.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  Widget _view = ProgressAdviceView();
  @override
  Widget build(BuildContext context) {
    return AumPage(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProgressBackButton(),
          Segment(
            child: ProgressDateSelect(),
            margin: EdgeInsets.symmetric(vertical: 24),
            padding: EdgeInsets.all(16),
          ),
          ProgressViewsChanger(
            onChangeView: (view) {
              setState(() {
                _view = view;
              });
            },
          ),
          Segment(
            child: _view,
            margin: EdgeInsets.symmetric(vertical: 24),
          ),
        ],
      ),
    );
  }
}

class _ProgressBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AumBackButton(
            color: AumColor.accent,
            onPressed: () {
              Navigator.pop(context);
            }),
        Padding(
            padding: EdgeInsets.only(left: 8),
            child: AumText.bold(
              'Dashboard',
              size: 24,
              color: AumColor.accent,
            ))
      ],
    );
  }
}
