import 'package:flutter/material.dart';
import 'package:share_preference_demo/pages/regist/regist_content.dart';

class JRRegistPage extends StatelessWidget {
  static const String routeName = '/regist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册 / 登陆'),
      ),
      body: JRRegistContent(),
    );
  }
}
