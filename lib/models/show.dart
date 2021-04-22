import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interviewtask/utils/parser.dart';

class Show extends ChangeNotifier {
  String name, image, summary, id;

  Show({this.name, this.image, this.summary, this.id});
  List<Show> shows = [];

  //Two constructors are used for getting model from JSON
  //First for search
  //Second for all shows.
  Show.fromJson(json) {
    id = json['show']['id'].toString();
    name = json['show']['name'];
    summary = SummaryParser.parseSummary(json['show']['summary']);
    if (json['show']['image'] != null) {
      image = json['show']['image']['medium'];
    } else {
      image = "";
    }
  }

  Show.fromGetAllJson(json) {
    id = json['id'].toString();
    name = json['name'];
    summary = SummaryParser.parseSummary(json['summary']);
    if (json['image'] != null) {
      image = json['image']['medium'];
    } else {
      image = "";
    }
  }

  //List of all TV Series.
  //This will be used to display the cards list.
  setShows(List<Show> shows) {
    this.shows = shows;
    notifyListeners();
  }

  //Clear all the shows
  clearShows() {
    this.shows = [];
    notifyListeners();
  }
}
