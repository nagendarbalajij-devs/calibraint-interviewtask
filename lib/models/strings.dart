import 'dart:developer';

import 'package:flutter/material.dart';

class Strings extends ChangeNotifier {
  int resultsLength;

  //Setting the number of results in search
  setResultLength(int length) {
    this.resultsLength = length;
    notifyListeners();
  }

  //Clearing the number
  clearResults() {
    this.resultsLength = null;
    notifyListeners();
  }
}
