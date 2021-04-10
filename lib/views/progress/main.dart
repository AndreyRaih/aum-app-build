import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/views/progress/components/profile/main.dart';
import 'package:aum_app_build/views/progress/components/notifications.dart';
import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/progress/components/asanas_list.dart';
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AumBackButton(
                  text: 'Dashboard',
                  color: AumColor.accent,
                  onPressed: () {
                    BlocProvider.of<NavigatorCubit>(context).navigatorPop();
                  },
                ),
                ProgressProfileNotifications()
              ],
            ),
            ProgressProfile(),
            ProgressWeekStat(),
            ProgressAsanasList()
          ],
        ),
      ),
    );
  }
}
