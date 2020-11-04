import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/data_row.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class DashboardPracticeComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (state is DashboardLoading) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AumColor.accent),
          ),
        );
      }
      Map preview = (state as DashboardPreview).preview;
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _PracticeImage(),
        _PracticeTitle(),
        _PracticeShortInfo(),
        AumPrimaryButton(
          onPressed: () {
            BlocProvider.of<NavigatorBloc>(context)
                .add(NavigatorPush(route: '/preview', arguments: preview));
          },
          text: 'Lets begin',
        )
      ]);
    });
  }
}

class _PracticeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Image.asset('img/dashboard_2.png'));
  }
}

class _PracticeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name =
        (BlocProvider.of<DashboardBloc>(context).state as DashboardPreview)
            .preview["name"];
    return Container(
        margin: EdgeInsets.only(bottom: 8.0),
        child: AumText.bold(name, size: 30.0));
  }
}

class _PracticeShortInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map preview =
        (BlocProvider.of<DashboardBloc>(context).state as DashboardPreview)
            .preview;
    final List<Map<String, dynamic>> _items = [
      {
        'label': 'Time',
        'value': '${(preview["time"] / 60).floor().toString()} min'
      },
      {'label': 'Calories', 'value': preview["cal"].toString()},
      {'label': 'Includes', 'value': preview["includes"].join(', ')}
    ];
    return Container(
        margin: EdgeInsets.only(bottom: 24.0), child: AumDataRow(data: _items));
  }
}
