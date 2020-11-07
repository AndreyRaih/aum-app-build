import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/progress/components/asanas_list.dart';
import 'package:aum_app_build/views/progress/components/comprasion.dart';
import 'package:aum_app_build/views/progress/components/week_stat.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/segment.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AumBackButton(
              text: 'Dashboard',
              color: AumColor.accent,
              onPressed: () {
                BlocProvider.of<NavigatorBloc>(context).add(NavigatorPop());
              }),
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
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
          )
        ],
      ),
    );
  }
}

class NoAccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(children: [
        Icon(
          AumIcon.info,
          size: 100,
          color: AumColor.additional.withOpacity(0.3),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            width: 200,
            child: Center(
                child: AumText.medium(
              'This feature will be avaliable in the full version of Aum App',
              size: 16,
              color: AumColor.additional,
              align: TextAlign.center,
            )))
      ])),
    );
  }
}
