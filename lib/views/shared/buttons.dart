import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/shadows.dart';
import 'package:flutter/material.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';

class AumPrimaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final bool disabled;
  final double width;
  AumPrimaryButton({@required this.onPressed, this.text, this.disabled = false, this.width = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: AumShadow.secondary),
        width: width,
        child: RaisedButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration: const BoxDecoration(
              gradient: AumColor.primary_gradient,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Container(
              padding: EdgeInsets.all(10.0),
              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
              alignment: Alignment.center,
              child: AumText.bold(text, size: 18.0, color: Colors.white),
            ),
          ),
        ));
  }
}

class AumSecondaryButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final bool disabled;
  AumSecondaryButton({@required this.onPressed, this.text, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      disabledElevation: 0.1,
      fillColor: AumColor.secondary,
      highlightColor: AumColor.secondary,
      child: Opacity(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(child: AumText.bold(text.toUpperCase(), size: 18.0)),
          ),
          opacity: disabled ? 0.2 : 1),
      onPressed: disabled ? null : onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}

class AumOutlineButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final Color color;
  final bool disabled;
  AumOutlineButton({@required this.onPressed, this.text, this.color = AumColor.accent, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Opacity(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: AumText.bold(text, size: 18.0, color: color),
          ),
          opacity: disabled ? 0.2 : 1),
      onPressed: onPressed,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0), side: BorderSide(width: 2, color: color)),
    );
  }
}

class AumBackButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final Color fillColor;
  final Color color;
  final String text;
  AumBackButton({@required this.onPressed, this.text, this.color = Colors.white, this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      RawMaterialButton(
        constraints: BoxConstraints(minWidth: 38.0, minHeight: 38.0),
        fillColor: fillColor,
        child: Icon(AumIcon.back, color: color, size: 38),
        onPressed: onPressed,
        shape: CircleBorder(),
      ),
      text != null
          ? Padding(
              padding: EdgeInsets.only(left: 8),
              child: AumText.bold(
                text,
                size: 24,
                color: color,
              ))
          : null
    ]);
  }
}

class AumCircularButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final Color fillColor;
  final Color color;
  final IconData icon;
  final double size;
  AumCircularButton({@required this.onPressed, this.icon, this.color = Colors.white, this.size = 38.0, this.fillColor});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      constraints: BoxConstraints(minWidth: size + 32, maxHeight: size + 32),
      padding: EdgeInsets.all(16),
      fillColor: fillColor,
      child: Icon(icon, color: color, size: size),
      onPressed: onPressed,
      shape: CircleBorder(),
    );
  }
}
