import 'package:flutter/material.dart';

class AumAvatar extends StatelessWidget {
  final String uri;
  final double size;
  AumAvatar({@required this.uri, this.size = 44.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(uri), fit: BoxFit.fill),
        ));
  }
}
