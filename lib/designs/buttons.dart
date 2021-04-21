import 'package:flutter/material.dart';
import 'package:interviewtask/designs/colours.dart';
import 'package:interviewtask/designs/texts.dart';
import 'package:interviewtask/utils/sizes.dart';

class Buttons {
  static Widget button(String title, dynamic callback) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
      child: Material(
        color: Colours.accent,
        borderRadius: BorderRadius.circular(2),
        child: InkWell(
          borderRadius: BorderRadius.circular(2),
          onTap: callback,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Sizes.ofHeight(1), horizontal: Sizes.ofWidth(2)),
            child: Center(
              child: Text(
                "$title",
                style: Texts.whiteSubText(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget disabledProgressButton() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colours.accent,
        borderRadius: BorderRadius.circular(10),
        child: Container(
            height: Sizes.ofHeight(6),
            //margin: EdgeInsets.symmetric(vertical: Sizes.ofHeight(1.2), horizontal: Sizes.ofWidth(2)),
            child: Center(
                child: SizedBox(
              height: Sizes.ofHeight(3),
              width: Sizes.ofHeight(3),
              child: CircularProgressIndicator(),
            ))),
      ),
    );
  }
}
