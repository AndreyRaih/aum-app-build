import 'package:aum_app_build/views/progress/components/advice_views/main.dart';
import 'package:aum_app_build/views/progress/components/compare_views/main.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class ProgressViewsChanger extends StatefulWidget {
  final Function(Widget) onChangeView;

  ProgressViewsChanger({@required this.onChangeView});

  @override
  _ProgressViewsChangerState createState() =>
      _ProgressViewsChangerState(onChangeView: onChangeView);
}

class _ProgressViewsChangerState extends State<ProgressViewsChanger> {
  final Function(Widget) onChangeView;
  _ProgressViewObject _currentView =
      _ProgressViewObject('advice', ProgressAdviceView());
  _ProgressViewsChangerState({@required this.onChangeView});

  void initState() {
    super.initState();
    // _setNewView(_currentView.view);
  }

  void _setNewView(_ProgressViewObject view) {
    setState(() {
      _currentView = view;
    });
    onChangeView(_currentView.view);
  }

  Widget _renderChangerOption({String label, Widget value}) {
    return GestureDetector(
        onTap: () {
          _setNewView(_ProgressViewObject(label.toLowerCase(), value));
        },
        child: Opacity(
            opacity: _currentView.name == label.toLowerCase() ? 1 : 0.5,
            child: AumText.bold(
              label,
              size: 24,
              color: AumColor.accent,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _renderChangerOption(label: 'Advice', value: ProgressAdviceView()),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: 2,
              height: 28,
              color: Colors.grey[300],
            )),
        _renderChangerOption(label: 'Compare', value: ProgressCompareView())
      ],
    );
  }
}

class _ProgressViewObject {
  String name;
  Widget view;
  _ProgressViewObject(String name, Widget view) {
    this.name = name;
    this.view = view;
  }
}
