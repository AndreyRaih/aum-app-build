import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class AumList extends StatelessWidget {
  final List<Widget> items;
  AumList({@required this.items});

  factory AumList.plain({List<String> list}) {
    List<Widget> _listItemViews = list
        .map((str) => Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AumColor.accent),
                    )),
                Expanded(
                    child: AumText.medium(str,
                        size: 16, color: AumColor.additional))
              ],
            )))
        .toList();
    return AumList(
      items: _listItemViews,
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: items,
    );
  }
}
