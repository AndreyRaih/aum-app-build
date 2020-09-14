import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/expanded_section.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class ProgressAsanaDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _AsanaDetailsTitle(),
      _AsanaDetailsImage(),
      _AsanaDetailsDescription(),
      AumExpandedSection(
        label: 'Benefits',
        content: _AsanaDetailsBenefits(),
      ),
      AumExpandedSection(
        label: 'Prohibitions',
        content: _AsanaDetailsProhibtions(),
      ),
    ]);
  }
}

class _AsanaDetailsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: AumText.bold(
          'Parivritta Parshvakonasana',
          size: 30,
        ));
  }
}

class _AsanaDetailsImage extends StatefulWidget {
  @override
  __AsanaDetailsImageState createState() => __AsanaDetailsImageState();
}

class __AsanaDetailsImageState extends State<_AsanaDetailsImage>
    with SingleTickerProviderStateMixin {
  bool _refVisible = false;
  AnimationController _controller;
  Animation<double> _expandAnimation;

  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 100));
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _toggleRef() {
    if (!_refVisible) {
      _showRef();
    } else {
      _hideRef();
    }
  }

  void _showRef() {
    setState(() {
      _refVisible = true;
    });
    _controller.forward();
  }

  void _hideRef() {
    setState(() {
      _refVisible = false;
    });
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://med-mash.ru/images/shutterstock_420977962.jpgx54339_2031'))),
          ),
          SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: _expandAnimation,
              child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://hebeyos.com/wp-content/uploads/2018/02/13330374_1733742980231456_1872416536_n.jpg')))))),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AumSecondaryButton(
                onPressed: () {
                  _toggleRef();
                },
                text: _refVisible ? 'Hide reference' : 'Compare with reference',
              ))
        ]));
  }
}

class _AsanaDetailsDescription extends StatelessWidget
    with _AsanaDetailTextList {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: AumText.bold(
                  'Pieces of advice',
                  size: 24,
                  color: AumColor.accent,
                )),
            Column(
              children: getWidgets(),
            )
          ],
        ));
  }
}

class _AsanaDetailsBenefits extends StatelessWidget with _AsanaDetailTextList {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: getWidgets(),
    );
  }
}

class _AsanaDetailsProhibtions extends StatelessWidget
    with _AsanaDetailTextList {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: getWidgets(),
    );
  }
}

abstract class _AsanaDetailTextList {
  final List<String> _adivces = [
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
  ];
  List<Widget> getWidgets() {
    List<Widget> _adivcesViews = _adivces
        .map((advice) => Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: AumText.medium(
                advice,
                size: 16,
                color: AumColor.additional,
              ),
            ))
        .toList();
    return _adivcesViews;
  }
}
