import 'dart:ui';

import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class PlayerModal extends StatefulWidget {
  _PlayerModalState createState() => _PlayerModalState();
}

class _PlayerModalState extends State<PlayerModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.25),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: AumText.bold('Content')),
      ),
    );
  }
}
