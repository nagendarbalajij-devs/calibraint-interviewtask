import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interviewtask/utils/parser.dart';

class Show extends ChangeNotifier {
  String name, image, summary, id;

  Show({this.name, this.image, this.summary, this.id});
  List<Show> shows = [];

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

  setShows(List<Show> shows) {
    this.shows = shows;
    notifyListeners();
  }

  clearShows() {
    this.shows = [];
    notifyListeners();
  }
}
