import 'package:flutter/material.dart';
import 'package:interviewtask/designs/colours.dart';
import 'package:interviewtask/utils/sizes.dart';

class Texts {
  static InputDecoration searchInputDecoration(var obj) {
    return InputDecoration(
      prefixIcon: Icon(Icons.search, color: Colours.accent),
      suffixIcon: IconButton(
        onPressed: () {
          obj.clearSearch();
        },
        icon: Icon(
          Icons.clear,
          color: Colours.accent,
        ),
      ),
      contentPadding: EdgeInsets.only(bottom: Sizes.ofHeight(3)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colours.accent, width: 1)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colours.accent, width: 1)),
    );
  }

  static white() {
    return TextStyle(color: Colors.white, fontSize: Sizes.fontSize);
  }

  static accentTextStyle() {
    return TextStyle(color: Colours.accent, fontSize: Sizes.fontSize);
  }

  static accentSubText() {
    return TextStyle(color: Colours.accent, fontSize: Sizes.fontSize * 0.8);
  }

  static whiteBig() {
    return TextStyle(color: Colors.white, fontSize: Sizes.fontSize * 1.7);
  }

  static whiteSubText() {
    return TextStyle(color: Colors.white, fontSize: Sizes.fontSize * 0.7);
  }

  static greySubText() {
    return TextStyle(color: Colors.grey[700], fontSize: Sizes.fontSize * 0.7);
  }
}
