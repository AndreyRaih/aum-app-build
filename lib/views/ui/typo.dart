import 'package:flutter/material.dart';
import 'package:aum_app_build/views/ui/palette.dart';

class AumText extends StatelessWidget {
  final String text;
  final double size;
  final String font;
  final Color color;
  AumText(this.text,
      {this.size = 18.0,
      this.font = 'GilroyRegular',
      this.color = AumColor.text});

  factory AumText.bold(String text,
      {double size, Color color = AumColor.text}) {
    String boldFont = 'GilroyBold';
    return AumText(text, size: size, font: boldFont, color: color);
  }
  factory AumText.medium(String text,
      {double size, Color color = AumColor.text}) {
    String mediumFont = 'GilroyMedium';
    return AumText(text, size: size, font: mediumFont, color: color);
  }
  factory AumText.regular(String text,
      {double size, Color color = AumColor.text}) {
    String regularFont = 'GilroyRegular';
    return AumText(text, size: size, font: regularFont, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontFamily: font),
      overflow: TextOverflow.ellipsis,
      maxLines: 20,
    );
  }
}
