import 'dart:developer';

import 'package:flutter/material.dart';

class Strings extends ChangeNotifier {
  int resultsLength;

  setResultLength(int length) {
    this.resultsLength = length;
    notifyListeners();
  }

  clearResults() {
    this.resultsLength = null;
    notifyListeners();
  }
}
