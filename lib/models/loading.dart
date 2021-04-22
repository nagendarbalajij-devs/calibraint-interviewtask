import 'package:flutter/material.dart';

class Loading extends ChangeNotifier {
  bool isLoading = true, initialLoadDone = false;

  //Initial loading and loading are set to true
  //Initial load is used to avoid progress indicator before first execution
  load() {
    initialLoadDone = true;
    isLoading = true;
    notifyListeners();
  }

  //Progress indicator is called off.
  stop() {
    isLoading = false;
    notifyListeners();
  }
}
