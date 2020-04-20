import 'package:flutter/material.dart';

import 'package:share_preference_demo/extensions/int_extension.dart';

class JRSubmitButton extends StatelessWidget {
  final String _buttonTitle;
  final Function tapAction;

  JRSubmitButton(this._buttonTitle, {this.tapAction});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20.px, 0, 20.px, 0),
        width: double.infinity,
        height: 45.px,
        child: FlatButton(
            color: Colors.blue,
            disabledColor: Colors.grey[400],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.px)),
            child: Text(
              _buttonTitle,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            onPressed: this.tapAction));
  }
}
