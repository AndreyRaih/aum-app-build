import 'package:flutter/material.dart';

class AumPage extends StatelessWidget {
  final Widget child;
  final bool isFullscreen;
  final Color _backgroundColor = Color.fromRGBO(241, 243, 246, 1);
  AumPage({@required this.child, this.isFullscreen = false})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        decoration: BoxDecoration(color: _backgroundColor),
        child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(color: _backgroundColor),
                padding: isFullscreen == true
                    ? null
                    : EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
                child: child)));
  }
}
