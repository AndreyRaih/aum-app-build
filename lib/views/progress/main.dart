import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/progress/components/asanas_list.dart';
import 'package:aum_app_build/views/progress/components/comprasion.dart';
import 'package:aum_app_build/views/progress/components/week_stat.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/page.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumPage(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AumBackButton(
                text: 'Dashboard',
                color: AumColor.accent,
                onPressed: () {
                  BlocProvider.of<NavigatorCubit>(context).navigatorPop();
                }),
            ProgressWeekStat(),
            ProgressAsanasList(),
            ProgressComprasion()
          ],
        ),
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
