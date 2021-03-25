import 'package:flutter/material.dart';

class AumShadow {
  static List<BoxShadow> primary = [
    BoxShadow(color: Colors.black.withOpacity(0.15), offset: Offset(0, 4), blurRadius: 36)
  ];

  static List<BoxShadow> secondary = [
    BoxShadow(color: Colors.black.withOpacity(0.15), offset: Offset(0, 4), blurRadius: 16)
  ];

  static List<BoxShadow> soft = [
    BoxShadow(color: Color(0xFFCAD5DD).withOpacity(0.65), offset: Offset(0, 2), blurRadius: 48)
  ];
}
