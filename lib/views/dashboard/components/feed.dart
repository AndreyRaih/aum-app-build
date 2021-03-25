import 'package:aum_app_build/common_bloc/user/user_event.dart';
import 'package:aum_app_build/common_bloc/user/user_state.dart';
import 'package:aum_app_build/common_bloc/user_bloc.dart';
import 'package:aum_app_build/data/constants.dart';
import 'package:aum_app_build/data/models/practice.dart';
import 'package:aum_app_build/views/shared/card.dart';
import 'package:aum_app_build/views/shared/loader.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/data_row.dart';
import 'package:flutter/material.dart';

class DashboardFeedComponent extends StatelessWidget {
  final List feed;

  DashboardFeedComponent({this.feed = const []});

  void _openPreview(BuildContext context) => BlocProvider.of<UserBloc>(context)
      .add(UserOnboardingRouteHook(onboardingTarget: UserOnboardingTarget.concept, route: PREVIEW_ROUTE_NAME));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      List<Widget> _cards = feed.asMap().entries.map((entry) {
        AumUserPractice _practice = entry.value;
        Widget _item = _ContentCard(
            image: _practice.img,
            title: _practice.name,
            content: _ShortPracticeDescription(_practice),
            actions: AumPrimaryButton(text: 'Lets Begin', onPressed: () => _openPreview(context)));
        if (entry.key < feed.length) {
          return Padding(padding: EdgeInsets.only(right: SMALL_OFFSET), child: _item);
        }
        return _item;
      }).toList();

      return _cards.length > 0
          ? SingleChildScrollView(
              clipBehavior: Clip.none,
              padding: EdgeInsets.only(bottom: SMALL_OFFSET, right: 20, left: 20),
              scrollDirection: Axis.horizontal,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: _cards))
          : Container(height: 400, child: AumLoader());
    });
  }
}

class _ShortPracticeDescription extends StatelessWidget {
  final AumUserPractice practice;
  _ShortPracticeDescription(this.practice);
  @override
  Widget build(BuildContext context) {
    AumUserPractice practice = (BlocProvider.of<UserBloc>(context).state as UserSuccess).personalSession;
    final List<Map<String, dynamic>> _items = [
      {'label': 'Time', 'value': '${(practice.time / 60).floor().toString()} min'},
      {'label': 'Calories', 'value': practice.cal.toString()},
      {'label': 'Includes', 'value': practice.accents.join(', ')}
    ];
    return AumDataRow(data: _items);
  }
}

class _ContentCard extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final Widget content;
  final Widget actions;
  final List<String> tags;

  _ContentCard({this.image, this.title, this.content, this.actions, this.tags});

  @override
  Widget build(BuildContext context) {
    Widget _image = image != null
        ? Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                image: DecorationImage(image: image, fit: BoxFit.cover)),
          )
        : Container();
    Widget _title = title != null
        ? Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: AumText.bold(title, size: 24),
          )
        : Container();
    Widget _content = content != null ? Container(margin: EdgeInsets.only(bottom: 24.0), child: content) : Container();
    Widget _tags = tags != null
        ? Padding(
            padding: EdgeInsets.only(bottom: MINI_OFFSET),
            child: Row(children: [
              AumText.regular('Matched with: ', color: AumColor.additional, size: 14),
              AumText.medium(tags.join(', '), color: AumColor.accent, size: 14)
            ]))
        : Container();
    Widget _actions = actions != null ? actions : Container();

    Widget _layout = Column(
      children: [
        _image,
        Container(
            padding: EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_title, _content, _tags, _actions]))
      ],
    );

    return Container(width: 300, child: AumCard(child: _layout));
  }
}
