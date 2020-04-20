import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_preference_demo/models/user_model.dart';
import 'package:share_preference_demo/tools/screen_fit_tool.dart';
import 'package:share_preference_demo/extensions/int_extension.dart';
import 'package:share_preference_demo/viewModels/user_view_model.dart';
import 'package:share_preference_demo/widgets/user_list_item.dart';

class JRSearchContent extends StatefulWidget {
  @override
  _JRSearchContentState createState() => _JRSearchContentState();
}

class _JRSearchContentState extends State<JRSearchContent> {
  TextEditingController searchController = TextEditingController();
  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTopSearchBarUI(context),
        Selector<JRUserViewModel, List<JRUserModel>>(
          selector: (ctx, userVM) {
            if (_keyword.length == 0 || _keyword == null) return [];
            return userVM.findUsers(_keyword);
          }, // 过滤
          shouldRebuild: (prev, next) => true, // 比较两个数组是否相同(不相同的时候才重新build)
          builder: (ctx, users, child) {
            if (users.length == 0 || users == null) {
              return Expanded(
                child: Container(
                  width: JRScreenFitTool.screenWidth,
                  height: JRScreenFitTool.screenHeight - JRScreenFitTool.navBarHeight -
                      JRScreenFitTool.statusBarHeight,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text('没有匹配的用户存在'),
                )
              );
            }

            return Expanded(
              child: Container(
                width: JRScreenFitTool.screenWidth,
                height: JRScreenFitTool.screenHeight -
                    JRScreenFitTool.navBarHeight -
                    JRScreenFitTool.statusBarHeight,
                color: Colors.white,
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemCount: users.length,
                    itemBuilder: (ctx, index) {
                      JRUserModel userModel = users[index];
                      return JRUserListItem(index, userModel, shouldShowDeleteIcon: false,);
                    }),
              )
            );
          },
        ),
      ],
    );
  }

  Widget buildTopSearchBarUI(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: JRScreenFitTool.screenWidth,
          height:
              JRScreenFitTool.navBarHeight + JRScreenFitTool.statusBarHeight,
          color: Colors.blue,
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: JRScreenFitTool.statusBarHeight,
              width: JRScreenFitTool.screenWidth,
            )),
        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: JRScreenFitTool.navBarHeight,
              width: JRScreenFitTool.screenWidth,
              color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10.px),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20.px,
                  ),
                  SizedBox(width: 10.px),
                  Container(
                    width: JRScreenFitTool.screenWidth - 100.px,
                    height: JRScreenFitTool.navBarHeight,
                    // color: Colors.red,
                    alignment: Alignment.centerLeft,
                    child: buildTextField(),
                  ),
                  SizedBox(
                      width: JRScreenFitTool.setPx(0.5),
                      height: JRScreenFitTool.navBarHeight - 10.px,
                      child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white))),
                  SizedBox(width: 15.px),
                  GestureDetector(
                    child: Text('取消',
                        style: TextStyle(fontSize: 16.px, color: Colors.white)),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget buildTextField() {
    return TextField(
      controller: searchController,
      onSubmitted: (value) {
        print(value);
        setState(() {
          _keyword = value;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "搜索用户",
          hintStyle: TextStyle(fontSize: 14.px, color: Colors.white)),
      style: TextStyle(fontSize: 14.px, color: Colors.white),
    );
  }
}
