import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:interviewtask/models/episode.dart';
import 'package:interviewtask/models/season.dart';
import 'package:interviewtask/models/show.dart';
import 'package:interviewtask/utils/dialogs.dart';

class Api {
  static String root = "https://api.tvmaze.com/api";
  static String search = "https://api.tvmaze.com/search/shows?q=";
  static String seasons = "https://api.tvmaze.com/shows/";
  static String episodes = "https://api.tvmaze.com/seasons/";
  static String allShows = "https://api.tvmaze.com/shows";

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

  static Future<List<Season>> getSeasons(String id) async {
    http.Response response = await http.get(Uri.parse("${seasons}${id}/seasons"));
    List results = json.decode(response.body);
    return results.map((e) => Season.fromJson(e)).toList();
  }

  static Future<List<Episode>> getEpisodes(String id) async {
    http.Response response = await http.get(Uri.parse("${episodes}${id}/episodes"));
    List results = json.decode(response.body);
    return results.map((e) => Episode.fromJson(e)).toList();
  }

  static Future<http.Response> getAllShows() {
    return http.get(Uri.parse("${allShows}"));
  }
}
