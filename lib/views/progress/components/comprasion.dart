import 'package:aum_app_build/views/ui/buttons.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/select.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/material.dart';

class ProgressComprasion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: _ComprasionTitle()),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: _ComprasionSettings()),
        _ComprasionView()
      ],
    );
  }
}

class _ComprasionTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: AumText.bold(
          'Comprasion',
          size: 28,
        ));
  }
}

class _ComprasionSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            AumSelect(
              label: 'Asana',
              options: [
                {'label': 'Trikonasana', 'value': 'trikonasana'},
                {
                  'label': 'Parivritta Parshvakonasana',
                  'value': 'parivritta_parshvakonasana'
                },
                {'label': 'Utkhatasana', 'value': 'utkhatasana'}
              ],
              onChanged: (option) {
                print(option);
              },
              selected: 'trikonasana',
            ),
            Padding(
                padding: EdgeInsets.only(top: 16),
                child: AumDateSelect(
                  label: 'Period',
                  onDateChanged: (date) {
                    print(date);
                  },
                ))
          ],
        ));
  }
}

class _ComprasionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: _ComprasionViewChanger(
              onChangeView: (view) {
                print(view);
              },
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Image.network(
                'https://med-mash.ru/images/shutterstock_420977962.jpgx54339_2031')),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: AumSecondaryButton(
              onPressed: () {},
              text: 'Share or save',
            ))
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

class _ComprasionViewChanger extends StatefulWidget {
  final Function(String) onChangeView;

  _ComprasionViewChanger({@required this.onChangeView});

  @override
  _ComprasionViewChangerState createState() =>
      _ComprasionViewChangerState(onChangeView: onChangeView);
}

class _ComprasionViewChangerState extends State<_ComprasionViewChanger> {
  final Function(String) onChangeView;
  String _currentView = 'now';
  _ComprasionViewChangerState({@required this.onChangeView});

  void initState() {
    super.initState();
  }

  void _setNewView(String view) {
    setState(() {
      _currentView = view;
    });
    onChangeView(_currentView);
  }

  Widget _renderChangerOption({String label, String value}) {
    return GestureDetector(
        onTap: () {
          _setNewView(value);
        },
        child: Opacity(
            opacity: _currentView == value ? 1 : 0.5,
            child: AumText.bold(
              label,
              size: 20,
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
        _renderChangerOption(label: 'Now', value: 'now'),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          width: 2,
          height: 24,
          color: Colors.grey[300],
        ),
        _renderChangerOption(label: 'Past', value: 'past'),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          width: 2,
          height: 24,
          color: Colors.grey[300],
        ),
        _renderChangerOption(label: 'Both', value: 'both')
      ],
    );
  }
}
