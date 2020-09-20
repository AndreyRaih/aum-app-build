import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class AsanaDetailImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://zenia.app/wp-content/uploads/2019/12/new_yoga_banner_small.jpg'),
                  fit: BoxFit.fill))),
      Container(
          height: 300,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.black.withOpacity(0.8),
            Colors.white.withOpacity(0)
          ], begin: Alignment.topCenter, end: Alignment(0.0, 1)))),
      Positioned(
          top: 24.0,
          left: 24,
          child: AumBackButton(
              text: 'Progress',
              onPressed: () {
                Navigator.pop(context);
              })),
    ]);
  }
}
