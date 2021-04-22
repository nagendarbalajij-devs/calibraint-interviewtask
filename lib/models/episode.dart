import 'package:flutter/material.dart';

class Episode extends ChangeNotifier {
  String id, name, image, airdate;
  int number, season, runtime;
  List<Episode> episodes = [];

  Episode({this.name, this.airdate, this.number, this.season, this.image, this.runtime});

  Episode.fromJson(json) {
    this.name = json['name'];
    this.airdate = json['airdate'];
    this.number = json['number'];
    this.season = json['season'];
    this.runtime = json['runtime'];
    if (json['image'] != null) {
      this.image = json['image']['medium'];
    } else {
      this.image = '';
    }
  }

  //List of episodes from JSON are added to episodes list
  //This is used to display episodes in a season
  addEpisodes(List<Episode> _episodes) {
    this.episodes = _episodes;
    notifyListeners();
  }

  //All entries in list of episodes will be cleared.
  //notifyListneres may not be needed. Added to avoid runtime errors & keep the code lite.
  clearEpisodes() {
    episodes.clear();
    notifyListeners();
  }
}
