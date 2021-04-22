import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:interviewtask/api/api.dart';
import 'package:interviewtask/designs/card.dart';
import 'package:interviewtask/designs/colours.dart';
import 'package:interviewtask/designs/progress.dart';
import 'package:interviewtask/designs/texts.dart';
import 'package:interviewtask/layouts/series_detail.dart';
import 'package:interviewtask/models/episode.dart';
import 'package:interviewtask/models/loading.dart';
import 'package:interviewtask/models/season.dart';
import 'package:interviewtask/models/show.dart';
import 'package:interviewtask/models/strings.dart';
import 'package:interviewtask/utils/sizes.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  //Search for a TV Series and the results will be displayed.
  //Upon clicking show episodes the series details page will be displayed for the selected TV Series

  //Controller for search
  var _searchController = new TextEditingController();

  //Common animation duration for text display of no of results and list view animation
  Duration _animeDuration = Duration(milliseconds: 250);
  Strings strings;

  //First time loading boolean. To avoid progress indicator from showing on inital load.
  bool firstSearchDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      body: Container(
        margin: EdgeInsets.only(top: Sizes.topPadding + Sizes.ofHeight(4)),
        child: Column(
          children: [
            //Search textfield
            Container(
              height: Sizes.ofHeight(6),
              padding: EdgeInsets.symmetric(horizontal: Sizes.ofWidth(4)),
              child: TextField(
                controller: _searchController,
                onEditingComplete: search,
                decoration: Texts.searchInputDecoration(this),
                style: Texts.accentSubText(),
                cursorColor: Colours.accent,
              ),
            ),

            //Displaying text that says no of. results found.
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: Sizes.ofWidth(4)),
              margin: EdgeInsets.only(top: Sizes.ofHeight(1)),
              child: AnimatedSize(
                  vsync: this,
                  duration: _animeDuration,
                  curve: Curves.fastOutSlowIn,
                  child: Consumer<Strings>(builder: (context, value, child) {
                    strings = value;
                    if (value.resultsLength == null) {
                      return Container();
                    } else {
                      return value.resultsLength > 0
                          ? Text(
                              "${value.resultsLength} results found",
                              style: Texts.whiteSubText(),
                            )
                          : Container(
                              child: Cards.noDataCard(),
                            );
                    }
                  })),
            ),

            //To create additional spacing in the column.
            SizedBox(
              height: Sizes.ofHeight(2),
            ),

            //Progress indicator
            //Progress indicator display will be controlled with Provider
            Progress.progressLoader(),

            //List view of search results. Will contain all TV Series fetched from API.
            Expanded(
                child: AnimatedSize(
              vsync: this,
              duration: _animeDuration,
              curve: Curves.fastOutSlowIn,
              child: Consumer<Show>(builder: (context, value, child) {
                return Container(
                    width: value.shows.length > 0 ? double.infinity : 0,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: Sizes.ofWidth(4)),
                      itemCount: value.shows.length,
                      //Custom List view for TV Series
                      itemBuilder: (context, index) => Cards.showCard(context, value.shows[index], showDetail),
                    ));
              }),
            ))
          ],
        ),
      ),
    );
  }

  search() async {
    //Removes keyboard after search
    FocusScope.of(context).unfocus();

    //Removes previous results.
    context.read<Show>().clearShows();

    //Showing progress indicator
    context.read<Loading>().load();

    //Gets all the shows as data models from API
    var shows = await Api.getSearch(_searchController.text);

    //Using provider to set shows so they will reflected in the search list
    context.read<Show>().setShows(shows);

    //Updating the result length in the strings text to update the text displated below serach text field.
    context.read<Strings>().setResultLength(shows.length);

    //Stop and hide progress indicator.
    context.read<Loading>().stop();
  }

  clearSearch() {
    //Called when clear button in search textfield is called.
    //The text is cleared.
    _searchController.clear();

    //Search result is cleared.
    context.read<Show>().clearShows();

    //Result length text is cleared.
    context.read<Strings>().clearResults();
  }

  showDetail(show) {
    //Called upon clicking Show Episodes button
    //Cleared all episodes and seasons list in Series detail screen.
    context.read<Episode>().clearEpisodes();
    context.read<Season>().clearSeasons();

    //Pushing to new screen to show TV Series detail.
    //Passing the currently selected show.
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowDetail(
            show: show,
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
