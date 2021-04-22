import 'dart:developer';

import 'package:flutter/material.dart';

class Sizes {
  BuildContext context;
  static double height, width, topPadding, bottomPadding, fontSize;
  double w, h;

  //Constructor will get the context.
  Sizes({this.context});
  static double ratio;

  initSize() {
    //Height, width, padding for top and bottom are assigned.
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    topPadding = MediaQuery.of(context).padding.top;

    //Font size will be calculated from the scale factor.
    fontSize = 0.05347 * width;
  }

  //Returns a percent of width passed.
  //If ratio = 10 and width = 500
  //The value returned will be 50
  static ofWidth(double ratio) {
    return width * (ratio / 100);
  }

  //Returns a percent of height passed.
  static ofHeight(double ratio) {
    return height * (ratio / 100);
  }
}
