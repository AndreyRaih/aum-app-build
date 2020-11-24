import 'package:aum_app_build/views/shared/icons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/title.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class FeedbackMemories extends StatefulWidget {
  final List<String> options;
  final Function(String) onChange;
  FeedbackMemories({@required this.options, this.onChange});

  @override
  _FeedbackMemoriesState createState() => _FeedbackMemoriesState();
}

class _FeedbackMemoriesState extends State<FeedbackMemories> {
  num _currentAsanaIndex = 0;
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
                  }
                },
                child: Icon(
                  AumIcon.arrow_left,
                  size: 36,
                  color: AumColor.accent.withOpacity(0.3),
                )),
            Expanded(
                child: Center(
                    child: AumText.bold(
              widget.options[_currentAsanaIndex],
              size: 24,
              color: AumColor.accent,
              align: TextAlign.center,
            ))),
            GestureDetector(
                onTap: () {
                  if (_currentAsanaIndex < widget.options.length - 1) {
                    setState(() {
                      _currentAsanaIndex++;
                    });
                  }
                },
                child: Icon(
                  AumIcon.arrow_right,
                  size: 36,
                  color: AumColor.accent.withOpacity(0.3),
                ))
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: GestureDetector(
                onTap: () =>
                    widget.onChange(widget.options[_currentAsanaIndex]),
                child: Icon(
                  AumIcon.photo,
                  size: 100,
                  color: AumColor.accent.withOpacity(0.3),
                ))),
        AumText.regular(
          'Tap on the icon to start the memorizing selected asana',
          size: 14,
          color: AumColor.additional,
          align: TextAlign.center,
        ),
      ],
    );
  }
}
