import 'package:aum_app_build/views/dashboard/bloc/dashboard_bloc.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_event.dart';
import 'package:aum_app_build/views/dashboard/bloc/dashboard_state.dart';
import 'package:aum_app_build/views/shared/buttons.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardSnippetsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> _tags = (BlocProvider.of<DashboardBloc>(context).state as DashboardPreview)
        .tags
        .map<Widget>((_tag) => AumOutlineButton(
              onPressed: () => BlocProvider.of<DashboardBloc>(context).add(DashboardSelectTag(_tag)),
              text: _tag,
            ))
        .toList();
    return Wrap(direction: Axis.horizontal, spacing: TINY_OFFSET, runSpacing: MINI_OFFSET, children: _tags);
  }
}
