import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class DashboardSnippetsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(direction: Axis.horizontal, spacing: SMALL_OFFSET, runSpacing: MINI_OFFSET, children: [
      AumOutlineButton(
        onPressed: () {},
        text: 'test test test',
      ),
      AumOutlineButton(
        onPressed: () {},
        text: 'test test',
      ),
      AumOutlineButton(
        onPressed: () {},
        text: 'test',
      ),
      AumOutlineButton(
        onPressed: () {},
        text: 'te',
      ),
      AumOutlineButton(
        onPressed: () {},
        text: 'test test test test',
      ),
    ]);
  }
}
