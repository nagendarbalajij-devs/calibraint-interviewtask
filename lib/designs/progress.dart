import 'package:flutter/material.dart';
import 'package:interviewtask/designs/colours.dart';
import 'package:interviewtask/models/loading.dart';
import 'package:provider/provider.dart';

class Progress {
  //Progress loader with providers enabled
  static Widget progressLoader() {
    return Container(
      child: Consumer<Loading>(
        builder: (context, value, child) {
          return value.isLoading
              ? value.initialLoadDone
                  ? progressIndicator()
                  : Container()
              : Container();
        },
      ),
    );
  }

  //Widget for progress indicator.
  static Widget progressIndicator() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colours.accent),
    );
  }
}
