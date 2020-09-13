import 'package:aum_app_build/views/ui/select.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class ProgressDateSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AumText.bold('Period', size: 24),
            AumDateSelect(
              onDateChanged: (date) {
                print(date);
              },
            )
          ],
        ));
  }
}
