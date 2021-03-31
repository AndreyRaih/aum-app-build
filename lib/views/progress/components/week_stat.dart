import 'package:aum_app_build/views/progress/bloc/progress_bloc.dart';
import 'package:aum_app_build/views/progress/bloc/progress_state.dart';
import 'package:aum_app_build/views/shared/card.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double _statisticHeight = 105;

class ProgressWeekStat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumCard(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SMALL_OFFSET, horizontal: MIDDLE_OFFSET),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_WeekStatTitle(), _WeekStatistic()],
        ),
      ),
    );
  }
}

class _WeekStatTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: 16), child: AumText.bold('Week', size: 28));
  }
}

class _WeekStatistic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressCubit, ProgressState>(builder: (context, state) {
      if (state is ProgressByWeek) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 40),
                child: _WeekStatisticSummaries(
                  time: state.totalTime,
                  calories: state.caloriesTotal,
                )),
            Expanded(
              child: _WeekStatisticBars(state.bars),
            )
          ],
        );
      }
      return AumLoader();
    });
  }
}

class _WeekStatisticSummaries extends StatelessWidget {
  final String time;
  final String calories;

  _WeekStatisticSummaries({this.time = '00:00:00', this.calories = '0'});

  Widget _renderSummary({String label, String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AumText.regular(label, size: 14, color: AumColor.text),
        AumText.bold(value, size: 24, color: AumColor.accent)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _statisticHeight,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderSummary(label: 'Calories', value: '$calories cal'),
            _renderSummary(label: 'Time', value: '$time'),
          ],
        ));
  }
}

class _WeekStatisticBars extends StatelessWidget {
  final List<double> bars;

  _WeekStatisticBars(this.bars);

  List<Widget> _renderBars(List<double> days) {
    List<Widget> _bars = days.map((value) {
      return Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 13,
          height: value > 0 ? value : 5,
          margin: EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(color: AumColor.accent, borderRadius: BorderRadius.circular(12)),
        ),
        AumText.medium(value.floor().toString(), size: 12, color: AumColor.additional),
      ]);
    }).toList();
    return _bars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _renderBars(bars),
    );
  }
}
