import 'package:flutter/material.dart';

class Episode extends ChangeNotifier {
  String id, name, image, airdate;
  int number, season, runtime;
  List<Episode> episodes = [];

  Episode({this.name, this.airdate, this.number, this.season, this.image, this.runtime});

  Episode.fromJson(json) {
    print("${json['runtime']}");
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

  addEpisodes(List<Episode> _episodes) {
    this.episodes = _episodes;
    notifyListeners();
  }

  clearEpisodes() {
    episodes.clear();
    notifyListeners();
  }
}
