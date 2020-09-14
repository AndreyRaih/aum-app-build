import 'package:aum_app_build/views/progress/components/advice_views/components/asana_details.dart';
import 'package:aum_app_build/views/progress/components/advice_views/components/day_changer.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class ProgressAdviceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProgressAdviceDayChanger(),
        Padding(
            padding: EdgeInsets.only(top: 16), child: ProgressAsanaDetails())
      ],
    );
  }
}
