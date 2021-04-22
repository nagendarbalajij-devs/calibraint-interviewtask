import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interviewtask/api/api.dart';
import 'package:interviewtask/designs/appbars.dart';
import 'package:interviewtask/designs/card.dart';
import 'package:interviewtask/designs/colours.dart';
import 'package:interviewtask/designs/progress.dart';
import 'package:interviewtask/layouts/series_detail.dart';
import 'package:interviewtask/models/episode.dart';
import 'package:interviewtask/models/season.dart';
import 'package:interviewtask/models/show.dart';
import 'package:interviewtask/utils/sizes.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  List<Show> shows = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: Appbars.mainAppBar("Dashboard", searchCallback),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: FutureBuilder(
              future: Api.getAllShows(),
              builder: (context, AsyncSnapshot<http.Response> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    List results = jsonDecode(snapshot.data.body);
                    shows = results.map((e) => Show.fromGetAllJson(e)).toList();
                    return Container(
                        child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: Sizes.ofWidth(4)),
                      itemCount: shows.length,
                      itemBuilder: (context, index) => Cards.showCard(context, shows[index], showDetail),
                    ));

                  default:
                    return Center(child: Progress.progressIndicator());
                }
              },
            ),
          ))
        ],
      ),
    );
  }

  searchCallback() {
    Navigator.pushNamed(context, '/search');
  }

  showDetail(show) {
    context.read<Episode>().clearEpisodes();
    context.read<Season>().clearSeasons();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowDetail(
            show: show,
          ),
        ));
  }
}
