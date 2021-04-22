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
  var _searchController = new TextEditingController();
  Duration _animeDuration = Duration(milliseconds: 250);
  Strings strings;
  bool firstSearchDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      body: Container(
        margin: EdgeInsets.only(top: Sizes.topPadding + Sizes.ofHeight(4)),
        child: Column(
          children: [
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
            SizedBox(
              height: Sizes.ofHeight(2),
            ),
            Progress.progressLoader(),
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
    FocusScope.of(context).unfocus();
    context.read<Show>().clearShows();
    context.read<Loading>().load();
    var shows = await Api.getSearch(_searchController.text);
    context.read<Show>().setShows(shows);
    context.read<Strings>().setResultLength(shows.length);
    context.read<Loading>().stop();
  }

  clearSearch() {
    _searchController.clear();
    context.read<Show>().clearShows();
    context.read<Strings>().clearResults();
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

  @override
  void dispose() {
    super.dispose();
  }
}
