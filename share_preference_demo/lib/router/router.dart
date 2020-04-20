import 'package:flutter/material.dart';
import 'package:share_preference_demo/pages/regist/regist.dart';
import 'package:share_preference_demo/pages/search/search.dart';
import 'package:share_preference_demo/pages/user/user_list.dart';

class JRRouter {
  // 默认启动路由
  static final String initialRoute = JRUserListPage.routeName;

  // 路由映射关系
  static final Map<String, WidgetBuilder> routers = {
    JRUserListPage.routeName: (ctx) => JRUserListPage(),
    JRSearchPage.routeName: (ctx) => JRSearchPage()
  };

  // 钩子函数
  static final RouteFactory generateRoute = (setttings) {
    if (setttings.name == JRRegistPage.routeName) { // modal方式弹出页面
        return MaterialPageRoute(builder: (ctx) {
          return JRRegistPage();
        },
        fullscreenDialog: true
      );
    }

    return null;
  };
}
