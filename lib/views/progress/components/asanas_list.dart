import 'package:aum_app_build/common_bloc/navigator/navigator_event.dart';
import 'package:aum_app_build/common_bloc/navigator_bloc.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
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
  Widget _renderAsanaListItem(asana, context) {
    return Container(
        padding: EdgeInsets.only(bottom: 16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 160, padding: EdgeInsets.only(right: 16, bottom: 4), child: AumText.bold(asana['asana'], size: 24, color: AumColor.accent)),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: AumText.medium('Success: ${asana['doneEntries'].length}', size: 14, color: AumColor.additional)),
                    AumText.medium('Fail: ${asana['failures'].length}', size: 14, color: AumColor.additional)
                  ],
                )
              ],
            ),
            Expanded(
                child: Column(children: [
              AumSecondaryButton(
                disabled: true,
                onPressed: () {
                  BlocProvider.of<NavigatorBloc>(context).add(NavigatorPush(route: '/asana-detail'));
                },
                text: 'Explore',
              ),
              Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: AumText.regular(
                    'Will be avaliable in full version',
                    size: 12,
                    color: AumColor.additional,
                    align: TextAlign.right,
                  ))
            ]))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final List _userAsanas = (BlocProvider.of<UserBloc>(context).state as UserSuccess).user.recentResults;
    List<Widget> _asanas = _userAsanas.map((asana) => _renderAsanaListItem(asana, context)).toList();
    return _asanas.length > 0
        ? Column(
            children: _asanas,
          )
        : Center(
            child: AumText.medium(
              'No one session yet',
              align: TextAlign.center,
              color: AumColor.additional,
            ),
          );
  }
}
