import 'dart:developer';

import 'package:flutter/material.dart';

class Sizes {
  BuildContext context;
  static double height, width, topPadding, bottomPadding, fontSize;
  double w, h;
  Sizes({this.context});
  static double ratio;

  initSize() {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    topPadding = MediaQuery.of(context).padding.top;
    fontSize = 0.05347 * width;
    log("Height $height  Width $width  Top $topPadding");
  }

  static ofWidth(double ratio) {
    return width * (ratio / 100);
  }

  static ofHeight(double ratio) {
    return height * (ratio / 100);
  }
}
