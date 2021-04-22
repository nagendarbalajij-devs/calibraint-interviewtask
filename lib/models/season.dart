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

  //Season are added to list.
  //This will be displayed as Seasons dropdown button
  addSeason(DropdownMenuItem season) {
    this.seasonsList.add(season);
    notifyListeners();
  }

  //Season which has been selected will be set.
  //Which will be used to download episodes and change the selected season in dropdown.
  selectSeason(Season season) {
    this.selectedSeason = season;
    notifyListeners();
  }

  //The first season is selected on default when series deatil view is loaded.
  selectFirstSeason() {
    this.selectedSeason = seasonsList[0].value;
    notifyListeners();
  }

  //Season list will be cleared when new TV Series is being loaded.
  clearSeasons() {
    this.seasonsList = [];
    this.selectedSeason = null;
    notifyListeners();
  }
}
