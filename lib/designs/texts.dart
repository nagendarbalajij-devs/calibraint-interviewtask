import 'package:flutter/material.dart';
import 'package:interviewtask/designs/colours.dart';
import 'package:interviewtask/utils/sizes.dart';

class Texts {
  //Text input decoration for search
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

  //White textstyle to display
  static white() {
    return TextStyle(color: Colors.white, fontSize: Sizes.fontSize);
  }

  //Accent coloured textstyle
  static accentTextStyle() {
    return TextStyle(color: Colours.accent, fontSize: Sizes.fontSize);
  }

  //Accent coloured textstyle in a smaller font.
  static accentSubText() {
    return TextStyle(color: Colours.accent, fontSize: Sizes.fontSize * 0.8);
  }

  //White coloured textstyle in a big font.
  static whiteBig() {
    return TextStyle(color: Colors.white, fontSize: Sizes.fontSize * 1.7);
  }

  //White coloured textstyle in a smaller font.
  static whiteSubText() {
    return TextStyle(
      color: Colors.white,
      fontSize: Sizes.fontSize * 0.7,
    );
  }

  //White coloured textstyle in a smaller font with increased line spacing for summary dialog.
  static whiteDialogSubText() {
    return TextStyle(color: Colors.white, fontSize: Sizes.fontSize * 0.7, height: Sizes.ofHeight(0.15));
  }

  //Grey coloured textstyle in a smaller font.
  static greySubText() {
    return TextStyle(color: Colors.grey[700], fontSize: Sizes.fontSize * 0.7);
  }
}
