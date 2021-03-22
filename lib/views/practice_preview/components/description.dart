import 'package:aum_app_build/data/models/practice.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_bloc.dart';
import 'package:aum_app_build/views/practice_preview/bloc/preview_state.dart';
import 'package:aum_app_build/views/shared/data_row.dart';
import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(bottom: 16), child: _MainPart()),
        Padding(padding: EdgeInsets.only(bottom: 24), child: _ShortTerm())
      ],
    );
  }
}

class _MainPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = (BlocProvider.of<PreviewBloc>(context).state as PreviewIsReady).preview.name;
    String description = (BlocProvider.of<PreviewBloc>(context).state as PreviewIsReady).preview.description;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.only(bottom: 8),
          child: AumText.bold(
            name,
            size: 32,
          )),
      AumText.regular(
        description,
        size: 16,
        color: AumColor.additional,
      )
    ]);
  }
}

class _ShortTerm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AumUserPractice practice = (BlocProvider.of<PreviewBloc>(context).state as PreviewIsReady).preview;

    final List<Map<String, dynamic>> _data = [
      {'label': 'Time', 'value': '${(practice.time / 60).floor().toString()} min'},
      {'label': 'Calories', 'value': practice.cal.toString()},
      {'label': 'Includes', 'value': practice.accents.join(', ')}
    ];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: AumDataRow(
        data: _data,
      ),
    );
  }
}
