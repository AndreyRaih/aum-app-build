import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class ProgressAsanasList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_AsanasListTitle(), _AsanasList()],
    );
  }
}

class _AsanasListTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: AumText.bold(
          'Asanas',
          size: 28,
        ));
  }
}

class _AsanasList extends StatelessWidget {
  final List<Map<String, dynamic>> _userAsanas = [
    {'name': 'Trikonasana', 'success': 1, 'fail': 3},
    {'name': 'Parivritta Parshvakonasana', 'success': 2, 'fail': 2},
    {'name': 'Utkhatasana', 'success': 1, 'fail': 4}
  ];

  Widget _renderAsanaListItem(asana, context) {
    return Container(
        padding: EdgeInsets.only(bottom: 16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 160,
                    padding: EdgeInsets.only(right: 16, bottom: 4),
                    child: AumText.bold(asana['name'],
                        size: 24, color: AumColor.accent)),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: AumText.medium('Success: ${asana['success']}',
                            size: 14, color: AumColor.additional)),
                    AumText.medium('Fail: ${asana['fail']}',
                        size: 14, color: AumColor.additional)
                  ],
                )
              ],
            ),
            Expanded(
                child: AumSecondaryButton(
              onPressed: () {
                Navigator.pushNamed(context, '/asana-detail');
              },
              text: 'Explore',
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _asanas = _userAsanas
        .map((asana) => _renderAsanaListItem(asana, context))
        .toList();
    return Column(
      children: _asanas,
    );
  }
}
