import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage('img/logo.png'))),
    );
  }
}
