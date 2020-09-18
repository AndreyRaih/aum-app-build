import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

const double _statisticHeight = 105;

class ProgressWeekStat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_WeekStatTitle(), _WeekStatistic()],
    );
  }
}

class _WeekStatTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: AumText.bold('Week', size: 28));
  }
}

class _WeekStatistic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
            padding: EdgeInsets.only(right: 40),
            child: _WeekStatisticSummaries()),
        Expanded(child: _WeekStatisticBars())
      ],
    );
  }
}

class _WeekStatisticSummaries extends StatelessWidget {
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
            _renderSummary(label: 'Calories', value: '1037 cal'),
            _renderSummary(label: 'Time', value: '03:02:37 '),
          ],
        ));
  }
}

class _WeekStatisticBars extends StatelessWidget {
  final List<double> _weekValues = [23, 33, 45, 60, 42, 31, 12];

  Widget _renderBar(double percentage) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 13,
          height: (percentage / 60) * 100,
          margin: EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
              color: AumColor.accent, borderRadius: BorderRadius.circular(12)),
        ),
        AumText.medium(percentage.toInt().toString(),
            size: 12, color: AumColor.additional)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _bars = _weekValues.map((value) => _renderBar(value)).toList();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _bars,
    );
  }
}
