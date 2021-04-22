import 'package:flutter/material.dart';
import 'package:interviewtask/designs/colours.dart';
import 'package:interviewtask/designs/texts.dart';
import 'package:interviewtask/utils/sizes.dart';

class Buttons {
  //Custom button for show episodes.
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
}
