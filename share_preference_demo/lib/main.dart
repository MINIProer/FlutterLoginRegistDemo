import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_preference_demo/router/router.dart';
import 'package:share_preference_demo/tools/screen_fit_tool.dart';
import 'package:share_preference_demo/viewModels/user_view_model.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => JRUserViewModel()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JRScreenFitTool.initialize();
    JRScreenFitTool.setStatusBarHeight(MediaQueryData.fromWindow(window).padding.top);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: JRRouter.initialRoute,
      routes: JRRouter.routers,
      onGenerateRoute: JRRouter.generateRoute,
    );
  }
}
