import 'package:aum_app_build/views/shared/palette.dart';
import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AumInput extends StatefulWidget {
  final String placeholder;
  final String label;
  final String value;
  final TextInputType type;
  final bool hasError;
  final bool hideText;
  final String errorMsg;
  final Function onInput;
  final bool isCentered;
  final double textSize;
  final TextInputFormatter customFormatter;
  final bool autofocus;
  AumInput({
    this.label,
    this.value,
    this.placeholder = 'Enter something',
    this.type = TextInputType.text,
    this.hasError = false,
    this.hideText = false,
    this.errorMsg,
    this.onInput,
    this.isCentered = false,
    this.textSize = 24,
    this.customFormatter,
    this.autofocus = false,
  });
  _AumInputState createState() => _AumInputState();
}

class _AumInputState extends State<AumInput> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.value != null) {
      _controller.text = widget.value;
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: 4));
      setState(() {});
    }
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
        autofocus: widget.autofocus,
        onChanged: widget.onInput,
        keyboardType: widget.type,
        placeholder: widget.placeholder,
        obscureText: widget.hideText,
        textAlign: widget.isCentered ? TextAlign.center : TextAlign.left,
        cursorColor: AumColor.additional,
        style: TextStyle(
            fontFamily: 'GilroyBold',
            fontSize: widget.textSize,
            color: widget.hasError ? Colors.red[400] : AumColor.accent),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        inputFormatters: widget.customFormatter != null ? [widget.customFormatter] : [],
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(width: 2, color: widget.hasError ? Colors.red[300] : Colors.grey[300]),
          ),
        ),
        controller: _controller,
      )
    ];
    if (widget.label != null) {
      Widget _upperLine = Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_label, _errorText]);
      _base.insert(0, _upperLine);
    }
    return _base;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: _renderTextInputParts());
  }
}

class AumInputFormatters {
  static final TextInputFormatter phoneNumber =
      new MaskTextInputFormatter(mask: '+1 (###) ###-##-##', initialText: '+1 (###) ###-##-##');
}
