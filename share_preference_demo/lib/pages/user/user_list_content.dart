import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_preference_demo/models/user_model.dart';
import 'package:share_preference_demo/viewModels/user_view_model.dart';
import 'package:share_preference_demo/widgets/user_list_item.dart';

class JRUserListContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<JRUserViewModel>(builder: (ctx, userVM, child) {
      final users = userVM.users;
      if (users.length == 0 || users == null) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            '暂无注册用户',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        );
      }
      return ListView.builder(
          itemCount: users.length,
          itemBuilder: (ctx, index) {
            JRUserModel userModel = users[index];
            return JRUserListItem(index, userModel);
          });
    });
  }
}
