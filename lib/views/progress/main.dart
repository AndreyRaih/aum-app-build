import 'package:aum_app_build/views/progress/components/asanas_list.dart';
import 'package:aum_app_build/views/progress/components/comprasion.dart';
import 'package:aum_app_build/views/progress/components/week_stat.dart';
import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/page.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/segment.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProgressBackButton(),
          Segment(
            child: ProgressWeekStat(),
            margin: EdgeInsets.symmetric(vertical: 24),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          Segment(
            child: ProgressAsanasList(),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          Segment(
            child: ProgressComprasion(),
            margin: EdgeInsets.only(top: 24),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          )
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
