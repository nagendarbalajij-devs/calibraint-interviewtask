import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interviewtask/designs/colours.dart';

class Appbars {
  static mainAppBar(String title, searchCallback) {
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: Colours.primary,
      centerTitle: true,
      title: Text(
        "$title",
        style: TextStyle(color: Colours.accent),
      ),
      actions: [
        Container(
          child: IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: Colours.accent,
            ),
            onPressed: searchCallback,
          ),
        )
      ],
    );
  }

  static appbarWithBackNav(String title) {
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: Colours.primary,
      centerTitle: true,
      title: Text(
        "$title",
        style: TextStyle(color: Colours.accent),
      ),
    );
  }
}
