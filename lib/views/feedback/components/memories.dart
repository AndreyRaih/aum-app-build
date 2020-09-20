import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/title.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class FeedbackMemories extends StatefulWidget {
  final Function(String) onChange;
  FeedbackMemories({this.onChange});

  @override
  _FeedbackMemoriesState createState() => _FeedbackMemoriesState();
}

class _FeedbackMemoriesState extends State<FeedbackMemories> {
  num _currentAsanaIndex = 0;
  List<String> _asanasOptions = [
    'Trikonasana',
    'Parivritta Parshvakonasana',
    'Utkhatasana'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AumTitle(
          text: 'Memories',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  if (_currentAsanaIndex >= 1) {
                    setState(() {
                      _currentAsanaIndex--;
                    });
                    widget.onChange(
                        _asanasOptions[_currentAsanaIndex].toLowerCase());
                  }
                },
                child: Icon(
                  AumIcon.arrow_left,
                  size: 24,
                  color: AumColor.accent.withOpacity(0.3),
                )),
            Expanded(
                child: Center(
                    child: AumText.bold(_asanasOptions[_currentAsanaIndex],
                        size: 20, color: AumColor.accent))),
            GestureDetector(
                onTap: () {
                  if (_currentAsanaIndex < _asanasOptions.length - 1) {
                    setState(() {
                      _currentAsanaIndex++;
                    });
                    widget.onChange(
                        _asanasOptions[_currentAsanaIndex].toLowerCase());
                  }
                },
                child: Icon(
                  AumIcon.arrow_right,
                  size: 24,
                  color: AumColor.accent.withOpacity(0.3),
                ))
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Icon(
              AumIcon.photo,
              size: 100,
              color: AumColor.accent.withOpacity(0.3),
            )),
        AumText.regular(
            'Tap on the icon to start the memorizing selected asana',
            size: 14,
            color: AumColor.additional),
      ],
    );
  }
}
