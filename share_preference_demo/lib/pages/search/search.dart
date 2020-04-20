import 'package:flutter/material.dart';

import 'package:share_preference_demo/pages/search/search_content.dart';

class JRSearchPage extends StatelessWidget {
  static const String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JRSearchContent(),
    );
  }
}
