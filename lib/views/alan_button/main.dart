import 'package:aum_app_build/views/shared/shadows.dart';
import 'package:flutter/material.dart';

class AumAlanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle, boxShadow: AumShadow.primary),
      ),
    );
  }
}
