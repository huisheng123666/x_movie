import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double mediaWidth = 0;

class Util {
  static calc(int px, BuildContext context) {
    if (mediaWidth == 0) {
      mediaWidth = MediaQuery.of(context).size.width;
    }
    return px / 375 * mediaWidth;
  }

  static screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static setStatusBarTextColor(SystemUiOverlayStyle theme) {
    SystemChrome.setSystemUIOverlayStyle(theme);
  }

  static bottomSafeHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}
