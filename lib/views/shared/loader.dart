import 'package:aum_app_build/views/shared/palette.dart';
import 'package:flutter/material.dart';

class AumLoader extends StatelessWidget {
  final bool centered;
  const AumLoader({this.centered = true});

  @override
  Widget build(BuildContext context) {
    Widget _loader = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AumColor.accent),
    );
    return centered ? Center(child: _loader) : _loader;
  }
}
