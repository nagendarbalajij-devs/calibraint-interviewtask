import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:interviewtask/models/episode.dart';
import 'package:interviewtask/models/season.dart';
import 'package:interviewtask/models/show.dart';
import 'package:interviewtask/utils/dialogs.dart';

class Api {
  //Root api for TVMaze
  static String root = "https://api.tvmaze.com/";

  //API for search
  static String search = "${root}search/shows?q=";

  //API to get TV Series season details
  static String seasons = "${root}shows/";

  //API to get episodes of the selected season
  static String episodes = "${root}seasons/";

  //API to get all TV Series
  static String allShows = "${root}shows";

  //API to get search results.
  //Search query is interpolated to search api.
  static Future<List<Show>> getSearch(String query) async {
    http.Response response = await http.get(Uri.parse("${search}${query}"));
    try {
      List results = json.decode(response.body);
      return results.map((e) => Show.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  //API to get all seasons for the selected TV Series
  //The TV Series (Show) id is interpolated with the /seasons
  static Future<List<Season>> getSeasons(String id) async {
    http.Response response = await http.get(Uri.parse("${seasons}${id}/seasons"));
    List results = json.decode(response.body);
    return results.map((e) => Season.fromJson(e)).toList();
  }

  //API to get all episodes in a season.
  //Season id is interpolated with episodes api with /episodes to get the list.
  static Future<List<Episode>> getEpisodes(String id) async {
    http.Response response = await http.get(Uri.parse("${episodes}${id}/episodes"));
    List results = json.decode(response.body);
    return results.map((e) => Episode.fromJson(e)).toList();
  }

  //API gets all TV Series
  static Future<http.Response> getAllShows() {
    return http.get(Uri.parse("${allShows}"));
  }
}
