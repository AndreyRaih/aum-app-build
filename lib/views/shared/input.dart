import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AumInput extends StatefulWidget {
  final String placeholder;
  final String label;
  final TextInputType type;
  final bool hasError;
  final bool hideText;
  final String errorMsg;
  final Function onInput;
  final bool isCentered;
  AumInput(
      {this.label,
      this.placeholder = 'Enter something',
      this.type = TextInputType.text,
      this.hasError = false,
      this.hideText = false,
      this.errorMsg,
      this.onInput,
      this.isCentered = false});
  _AumInputState createState() => _AumInputState();
}

class _AumInputState extends State<AumInput> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _renderTextInputParts() {
    Widget _errorText = widget.errorMsg != null && widget.hasError
        ? AumText.regular(
            widget.errorMsg,
            color: Colors.red[300],
            size: 12,
            align: TextAlign.end,
          )
        : Container();
    Widget _label = AumText.regular(
      widget.label,
      color: widget.hasError ? Colors.red[400] : AumColor.text,
    );
    List<Widget> _base = [
      CupertinoTextField(
        onChanged: widget.onInput,
        keyboardType: widget.type,
        placeholder: widget.placeholder,
        obscureText: widget.hideText,
        textAlign: widget.isCentered ? TextAlign.center : TextAlign.left,
        style: TextStyle(
            fontFamily: 'GilroyBold',
            color: widget.hasError ? Colors.red[400] : AumColor.accent),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
                bottom: BorderSide(
                    width: 2,
                    color:
                        widget.hasError ? Colors.red[300] : Colors.grey[300]))),
        controller: _controller,
      )
    ];
    if (widget.label != null) {
      Widget _upperLine = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_label, _errorText]);
      _base.insert(0, _upperLine);
    }
    return _base;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _renderTextInputParts());
  }
}
