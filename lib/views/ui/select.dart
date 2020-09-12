import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AumSelect extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final String label;
  dynamic selected;
  AumSelect({@required this.options, this.selected, this.label});
  _AumSelectState createState() => _AumSelectState(
      options:
          options.map((option) => _AumSelectOption.fromList(option)).toList(),
      selected: selected,
      label: label);
}

class _AumSelectState extends State<AumSelect> {
  final String label;
  final List<_AumSelectOption> options;
  _AumSelectOption _selectedOption;
  dynamic selected;

  _AumSelectState({@required this.options, this.selected = null, this.label});

  void initState() {
    super.initState();
    if (selected != null && options.length > 0) {
      _setDefaultOption(selected);
    }
  }

  void _setDefaultOption(dynamic selected) {
    _AumSelectOption option = options
        .firstWhere((option) => option.value == selected, orElse: () => null);
    setState(() {
      _selectedOption = option;
    });
  }

  void _showPicker() {
    List<Widget> _items = options
        .map((option) => Center(
                child: Text(
              option.label,
              style: TextStyle(color: Colors.black, fontSize: 20),
            )))
        .toList();
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 4,
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              children: _items,
              itemExtent: 50,
              onSelectedItemChanged: (int index) {
                setState(() {
                  _selectedOption = options[index];
                });
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(),
      child: _AumSelectPresentationView(
          label: label,
          text: _selectedOption != null ? _selectedOption.label : null),
    );
  }
}

class _AumSelectPresentationView extends StatelessWidget {
  final String label;
  final String text;
  final String placeholder;
  _AumSelectPresentationView(
      {this.text, this.label, this.placeholder = 'Choose something...'});

  Widget _renderLabel() {
    return Padding(
      child: AumText.regular(label),
      padding: EdgeInsets.only(bottom: 4),
    );
  }

  Widget _renderSelect() {
    final Widget textField = text != null
        ? AumText.bold(
            text,
            size: 20,
          )
        : Opacity(
            opacity: 0.5,
            child: AumText.bold(
              placeholder,
              size: 20,
            ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textField,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(AumIcon.arrow_down, color: AumColor.accent, size: 10))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: label != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_renderLabel(), _renderSelect()],
              )
            : _renderSelect());
  }
}

class _AumSelectOption {
  String label;
  dynamic value;
  _AumSelectOption.fromList(option) {
    this.label = option["label"];
    this.value = option["value"];
  }
}
