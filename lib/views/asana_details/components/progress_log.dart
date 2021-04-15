import 'package:aum_app_build/views/asana_details/bloc/details_state.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/shadows.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AsanaProgressLog extends StatelessWidget {
  final List<AsanaHistoryItem> log;

  AsanaProgressLog(this.log);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: log
          .map((item) => Padding(
                padding: EdgeInsets.only(bottom: MIDDLE_OFFSET),
                child: _LogItem(item),
              ))
          .toList(),
    );
  }
}

class _LogItem extends StatelessWidget {
  AsanaHistoryItem item;

  final Map<String, String> emojisMap = {
    "perfect": "Smiling Face",
    "well": "Slightly Smiling Face",
    "normal": "Neutral Face",
    "quite hard": "Confused Face",
  };

  _LogItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: SMALL_OFFSET),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: AumColor.secondary),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: MINI_OFFSET),
                    child: AumText.medium(
                      DateFormat('dd.MM.yyyy').format(item.date),
                      size: 18,
                    )),
                Container(
                    width: 280,
                    child: Wrap(children: [
                      AumText.regular(
                        item.note.split('{range}')[0],
                        size: 14,
                        color: AumColor.additional,
                      ),
                      AumText.regular(
                        item.range,
                        size: 14,
                        color: AumColor.accent,
                      ),
                      AumText.regular(
                        item.note.split('{range}')[1],
                        size: 14,
                        color: AumColor.additional,
                      )
                    ])),
              ],
            ),
            Text(
              Emoji.byName(emojisMap[item.range]).char,
              style: TextStyle(fontSize: 40, shadows: AumShadow.secondary),
            )
          ],
        ));
  }
}
