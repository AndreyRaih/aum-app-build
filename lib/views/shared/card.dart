import 'package:aum_app_build/views/shared/loader.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class AumCard extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final Widget content;
  final Widget actions;
  final double padding;
  final double margin;
  final bool isLoading;

  final double _borderRadius = 30.0;

  AumCard({this.image, this.title, this.content, this.actions, this.padding = 24, this.margin = 24, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    Widget _image = image != null
        ? Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(_borderRadius), topRight: Radius.circular(_borderRadius)),
                image: DecorationImage(image: image, fit: BoxFit.cover)),
          )
        : Container();
    Widget _title = title != null
        ? Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: AumText.bold(title, size: 30.0),
          )
        : Container();
    Widget _content = content != null ? Container(margin: EdgeInsets.only(bottom: 24.0), child: content) : Container();
    Widget _actions = actions != null ? Container(child: actions) : Container();
    Widget _container = Column(
      children: [
        _image,
        Container(padding: EdgeInsets.all(padding), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_title, _content, _actions]))
      ],
    );
    Widget _loader = Container(padding: EdgeInsets.all(padding), child: AumLoader());
    return Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(_borderRadius)),
        margin: EdgeInsets.symmetric(vertical: margin),
        child: !isLoading ? _container : _loader);
  }
}
