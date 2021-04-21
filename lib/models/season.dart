import 'package:flutter/material.dart';

class Season extends ChangeNotifier {
  int number, id;
  Season selectedSeason;

  Season({this.number, this.id});
  List<DropdownMenuItem> seasonsList = [];

  Season.fromJson(json) {
    this.number = json['number'];
    this.id = json['id'];
  }

  addSeason(DropdownMenuItem season) {
    this.seasonsList.add(season);
    notifyListeners();
  }

  selectSeason(Season season) {
    this.selectedSeason = season;
    notifyListeners();
  }

  selectFirstSeason() {
    this.selectedSeason = seasonsList[0].value;
    notifyListeners();
  }

  clearSeasons() {
    this.seasonsList = [];
    this.selectedSeason = null;
    notifyListeners();
  }
}
