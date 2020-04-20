import 'package:flutter/material.dart';
import 'package:share_preference_demo/pages/regist/regist.dart';
import 'package:share_preference_demo/pages/search/search.dart';
import 'package:share_preference_demo/pages/user/user_list_content.dart';
import 'package:share_preference_demo/extensions/int_extension.dart';

class JRUserListPage extends StatelessWidget {
  static const String routeName = '/userList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户列表'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(10.px),
              child: GestureDetector(
                child: Icon(Icons.search, color: Colors.white),
                onTap: () {
                  Navigator.of(context).pushNamed(JRSearchPage.routeName);
                },
              ))
        ],
      ),
      body: JRUserListContent(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => showRegistPage(context)),
    );
  }

  void showRegistPage(BuildContext context) {
    Navigator.of(context).pushNamed(JRRegistPage.routeName);
  }
}
