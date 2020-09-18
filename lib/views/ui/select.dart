import 'package:aum_app_build/views/ui/icons.dart';
import 'package:aum_app_build/views/ui/palette.dart';
import 'package:aum_app_build/views/ui/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
 * Common type for a all selectable widgets in App
 */
class _AumSelectOption {
  String label;
  dynamic value;
  _AumSelectOption.fromList(option) {
    this.label = option["label"];
    this.value = option["value"];
  }
}

/*
 * Abstract class which implements all basicly features of selections.
 * For example: show bottom sheet modal, set default value etc.
 */
abstract class _AumSelectingFeatures {
  _AumSelectOption _setDefaultOption(
      dynamic selected, List<_AumSelectOption> options) {
    _AumSelectOption option = options
        .firstWhere((option) => option.value == selected, orElse: () => null);
    return option;
  }

  void _showPicker(BuildContext context, Widget picker) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return picker;
        });
  }
}

class AumSelect extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final String label;
  final Function(_AumSelectOption) onChanged;
  final dynamic selected;
  AumSelect(
      {@required this.options,
      @required this.onChanged,
      this.selected,
      this.label});
  _AumSelectState createState() => _AumSelectState(
      options:
          options.map((option) => _AumSelectOption.fromList(option)).toList(),
      selected: selected,
      label: label,
      onChanged: onChanged);
}

class _AumSelectState extends State<AumSelect> with _AumSelectingFeatures {
  final Function(_AumSelectOption) onChanged;
  final List<_AumSelectOption> options;
  final dynamic selected;
  final String label;
  _AumSelectOption _selectedOption;

  _AumSelectState(
      {@required this.options,
      @required this.onChanged,
      this.selected,
      this.label});

  void initState() {
    super.initState();
    if (selected != null && options.length > 0) {
      _AumSelectOption _defaultOption = _setDefaultOption(selected, options);
      if (_defaultOption != null) _setOption(_defaultOption);
    }
  }

  void _setOption(_AumSelectOption option) {
    setState(() {
      _selectedOption = option;
    });
    onChanged(_selectedOption);
  }

  void _showSelectPicker() {
    List<Widget> _items = options
        .map((option) => Center(
                child: Text(
              option.label,
              style: TextStyle(color: Colors.black, fontSize: 20),
            )))
        .toList();
    Widget selectPicker = Container(
      height: MediaQuery.of(context).copyWith().size.height / 4,
      child: CupertinoPicker(
        backgroundColor: Colors.white,
        children: _items,
        itemExtent: 50,
        onSelectedItemChanged: (int index) {
          _setOption(options[index]);
        },
      ),
    );
    _showPicker(context, selectPicker);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectPicker(),
      child: _AumSelectPresentationView(
          label: label,
          text: _selectedOption != null ? _selectedOption.label : null),
    );
  }
}

class AumDateSelect extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChanged;
  final String label;
  AumDateSelect({this.date, @required this.onDateChanged, this.label});
  _AumDateSelectState createState() => _AumDateSelectState(
      date: date, onDateChanged: onDateChanged, label: label);
}

class _AumDateSelectState extends State<AumDateSelect>
    with _AumSelectingFeatures {
  final DateTime date;
  final Function(DateTime) onDateChanged;
  final String label;
  DateTime _selectedDate;
  _AumDateSelectState({this.date, @required this.onDateChanged, this.label});

  void _setOption(DateTime _date) {
    setState(() {
      _selectedDate = _date;
    });
    onDateChanged(_selectedDate);
  }

  void _showDatePicker() {
    Widget datePicker = Container(
        height: MediaQuery.of(context).copyWith().size.height / 4,
        child: CupertinoDatePicker(
          backgroundColor: Colors.white,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (DateTime newdate) {
            _setOption(newdate);
          },
          minimumYear: 2010,
          mode: CupertinoDatePickerMode.date,
        ));
    _showPicker(context, datePicker);
  }

  @override
  Widget build(BuildContext context) {
    DateTime _date = _selectedDate != null ? _selectedDate : DateTime.now();
    String dateStr = DateFormat('dd MMM yyyy').format(_date);
    return GestureDetector(
      onTap: () => _showDatePicker(),
      child: _AumSelectPresentationView(label: label, text: dateStr),
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
                Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
        child: label != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_renderLabel(), _renderSelect()],
              )
            : _renderSelect());
  }
}
