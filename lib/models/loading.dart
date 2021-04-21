import 'package:flutter/material.dart';

class Loading extends ChangeNotifier {
  bool isLoading = true, initialLoadDone = false;

  load() {
    initialLoadDone = true;
    isLoading = true;
    notifyListeners();
  }

  stop() {
    isLoading = false;
    notifyListeners();
  }
}
