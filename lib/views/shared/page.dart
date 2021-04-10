import 'package:flutter/material.dart';

class AumPage extends StatelessWidget {
  final Widget child;
  final bool isFullscreen;
  final Color _backgroundColor = Color.fromRGBO(252, 252, 252, 1);
  AumPage({@required this.child, this.isFullscreen = false}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        decoration: BoxDecoration(color: _backgroundColor),
        child: SingleChildScrollView(
            child: Container(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                decoration: BoxDecoration(color: _backgroundColor),
                padding: isFullscreen == true ? null : EdgeInsets.symmetric(vertical: 40.0),
                child: child)));
  }
}
