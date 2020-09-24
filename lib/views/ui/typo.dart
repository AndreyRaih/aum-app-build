import 'package:flutter/material.dart';
import 'package:aum_app_build/views/ui/palette.dart';

class AumText extends StatelessWidget {
  final String text;
  final double size;
  final String font;
  final Color color;
  final TextAlign align;
  AumText(this.text,
      {this.size = 18.0,
      this.font = 'GilroyRegular',
      this.color = AumColor.text,
      this.align = TextAlign.start});

  factory AumText.bold(String text,
      {double size,
      Color color = AumColor.text,
      TextAlign align = TextAlign.start}) {
    String boldFont = 'GilroyBold';
    return AumText(text,
        size: size, font: boldFont, color: color, align: align);
  }
  factory AumText.medium(String text,
      {double size,
      Color color = AumColor.text,
      TextAlign align = TextAlign.start}) {
    String mediumFont = 'GilroyMedium';
    return AumText(text,
        size: size, font: mediumFont, color: color, align: align);
  }
  factory AumText.regular(String text,
      {double size,
      Color color = AumColor.text,
      TextAlign align = TextAlign.start}) {
    String regularFont = 'GilroyRegular';
    return AumText(text,
        size: size, font: regularFont, color: color, align: align);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontFamily: font),
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      maxLines: 20,
    );
  }
}
