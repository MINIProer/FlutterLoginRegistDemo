

import 'package:share_preference_demo/tools/screen_fit_tool.dart';

extension IntFit on int {
  double get px {
    return JRScreenFitTool.setPx(this.toDouble());
  }

  double get rpx {
    return JRScreenFitTool.setRpx(this.toDouble());
  }
}
