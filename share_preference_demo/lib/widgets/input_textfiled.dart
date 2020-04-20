import 'package:flutter/material.dart';

enum JRInputTextFieldType { defaultStyle, registStyle }

class JRInputTextField extends StatelessWidget {
  final JRInputTextFieldType type;
  final String _labelTextString;
  final bool needSecure;
  bool shouldShowErrorMsg;
  String errorMsg;
  TextEditingController _controller;
  Function textChangeFunc;

  JRInputTextField(this._labelTextString, this._controller,
      {this.type = JRInputTextFieldType.defaultStyle,
      this.textChangeFunc,
      this.needSecure = false,
      this.shouldShowErrorMsg = false,
      this.errorMsg
      });

  @override
  Widget build(BuildContext context) {
    return buildTextFieldUI(this.type);
  }

  Widget buildTextFieldUI(JRInputTextFieldType type) {
    if (type == JRInputTextFieldType.defaultStyle) {
      return TextField(
        controller: _controller,
        onChanged: this.textChangeFunc,
        decoration: InputDecoration(
            labelText: _labelTextString,
            errorText: this.shouldShowErrorMsg ? this.errorMsg : null,
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
        obscureText: this.needSecure,
        autofocus: true,
      );
    } else if (type == JRInputTextFieldType.registStyle) {
      return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextField(
          controller: _controller,
          onChanged: this.textChangeFunc,
          decoration: InputDecoration(
              labelText: _labelTextString,
              errorText: this.shouldShowErrorMsg ? this.errorMsg : null,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue))),
          obscureText: this.needSecure,
          autofocus: true,
        ),
      );
    }

    return TextField(
      controller: _controller,
      onChanged: this.textChangeFunc,
      decoration: InputDecoration(
          labelText: _labelTextString,
          errorText: this.shouldShowErrorMsg ? this.errorMsg : null,
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
      obscureText: this.needSecure,
      autofocus: true,
    );
  }
}
