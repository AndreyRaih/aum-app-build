import 'package:aum_app_build/common_bloc/navigator/navigator_cubit.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/views/progress/bloc/progress_cubit.dart';
import 'package:aum_app_build/views/progress/bloc/progress_state.dart';
import 'package:aum_app_build/views/shared/card.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';

class ProgressAsanasList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AumCard(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SMALL_OFFSET, horizontal: MIDDLE_OFFSET),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_AsanasListTitle(), _AsanasList()],
        ),
      ),
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
  Widget _renderAsanaListItem(AsanaNote note, context) {
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
                Container(
                  width: 160,
                  padding: EdgeInsets.only(right: 16, bottom: 4),
                  child: AumText.bold(note.name, size: 24, color: AumColor.accent),
                ),
                AumText.medium(
                  'Notes: ${note.notes.length}',
                  size: 14,
                  color: AumColor.additional,
                )
              ],
            ),
            Expanded(
                child: Column(children: [
              AumSecondaryButton(
                onPressed: () {
                  BlocProvider.of<NavigatorCubit>(context).navigatorPush(DETAILS_ROUTE_NAME, arguments: note);
                },
                text: 'Explore',
              ),
            ]))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressCubit, ProgressState>(builder: (context, state) {
      if (state is ProgressByWeek) {
        List<Widget> _asanas = state.notes.map((note) => _renderAsanaListItem(note, context)).toList();
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
      return AumLoader();
    });
  }
}
