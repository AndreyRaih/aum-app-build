import 'package:aum_app_build/views/ui/icons.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';

class AumSecondaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  AumSecondaryButton({@required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: AumColor.secondary,
      highlightColor: AumColor.secondary,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(child: AumText.bold(text.toUpperCase(), size: 18.0)),
      ),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}

class AumPrimaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  AumPrimaryButton({@required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: AumColor.accent,
      highlightColor: AumColor.accent,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
            child: AumText.bold(text.toUpperCase(),
                size: 18.0, color: Colors.white)),
      ),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}

class AumBackButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final Color fillColor;
  final Color color;
  AumBackButton(
      {@required this.onPressed,
      this.color = Colors.white,
      this.fillColor = null});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: fillColor,
      child: Icon(AumIcon.back, color: color, size: 38),
      onPressed: onPressed,
      shape: CircleBorder(),
    );
  }
}
