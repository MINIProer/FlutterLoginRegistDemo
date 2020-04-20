import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:share_preference_demo/extensions/int_extension.dart';
import 'package:share_preference_demo/extensions/local_storage_extension.dart';
import 'package:share_preference_demo/models/user_model.dart';
import 'package:share_preference_demo/tools/local_storage_tool.dart';
import 'package:share_preference_demo/tools/screen_fit_tool.dart';
import 'package:share_preference_demo/viewModels/user_view_model.dart';

class JRUserListItem extends StatelessWidget {
  final int _index;
  final JRUserModel _userModel;
  final bool shouldShowDeleteIcon;

  JRUserListItem(this._index, this._userModel, {this.shouldShowDeleteIcon = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: double.infinity,
            height: 80.px,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.px),
            child: Container(
              width: 50.px,
              height: 50.px,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, Random().nextInt(256) + 0,
                      Random().nextInt(256) + 0, Random().nextInt(256) + 0),
                  borderRadius: BorderRadius.circular(25.px)),
              child: Text(
                '${_index + 1}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )),
        Positioned(
            left: 0,
            bottom: 0,
            child: SizedBox(
              height: 1.px,
              width: JRScreenFitTool.screenWidth,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey[350])),
            )),
        Positioned(
            left: 80.px,
            top: 15.px,
            child: Text('用户名：${_userModel.username}',
                style: TextStyle(fontSize: 16.px))),
        Positioned(
            left: 80.px,
            bottom: 15.px,
            child: Text('密码：${_userModel.password}',
                style: TextStyle(fontSize: 13.px, color: Colors.grey))),
        this.shouldShowDeleteIcon ?
        Positioned(
            right: 15.px,
            top: JRScreenFitTool.setPx(27.5),
            child: Consumer<JRUserViewModel>(builder: (context, userVM, child) {
              return GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey[400],
                  size: 25.px,
                ),
                onTap: () {
                  JRLocalStorage.get('UserList').then((res) {
                    JRUserLoacalData.deleteUserFromUserListMap(res, _index);
                  });

                  userVM.delete(userVM.users[_index]);
                },
              );
            })) : Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 1.px,
                      color: Colors.white,
                    )
                  )
      ],
    );
  }
}
