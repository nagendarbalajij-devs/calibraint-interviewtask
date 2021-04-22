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
  //shows contains all Series from the API
  List<Show> shows = [];

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
              //Getting all TV Series futures from API
              future: Api.getAllShows(),
              builder: (context, AsyncSnapshot<http.Response> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    //Changing JSON response to List<Show> data models.
                    List results = jsonDecode(snapshot.data.body);
                    shows = results.map((e) => Show.fromGetAllJson(e)).toList();
                    return Container(
                        child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: Sizes.ofWidth(4)),
                      itemCount: shows.length,
                      //displaying with custom list view
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
    //Route to show search
    Navigator.pushNamed(context, '/search');
  }

  showDetail(show) {
    //Clearing seasons and episodes before loading the newly selected series.
    context.read<Episode>().clearEpisodes();
    context.read<Season>().clearSeasons();

    //Passing the show to ShowDetail to view series details.
    //Routing to the page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowDetail(
            show: show,
          ),
        ));
  }
}
