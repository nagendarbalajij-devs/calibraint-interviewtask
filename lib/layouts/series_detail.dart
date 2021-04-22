import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interviewtask/api/api.dart';
import 'package:interviewtask/designs/appbars.dart';
import 'package:interviewtask/designs/card.dart';
import 'package:interviewtask/designs/colours.dart';
import 'package:interviewtask/designs/progress.dart';
import 'package:interviewtask/designs/texts.dart';
import 'package:interviewtask/models/episode.dart';
import 'package:interviewtask/models/loading.dart';
import 'package:interviewtask/models/season.dart';
import 'package:interviewtask/models/show.dart';
import 'package:interviewtask/utils/dialogs.dart';
import 'package:interviewtask/utils/sizes.dart';
import 'package:provider/provider.dart';

class ShowDetail extends StatefulWidget {
  Show show;
  ShowDetail({@required this.show});
  @override
  _ShowDetailState createState() => _ShowDetailState(show: show);
}

class _ShowDetailState extends State<ShowDetail> with TickerProviderStateMixin {
  //TV Series detail view.
  //Default constructor will get the selected TV Series while pushing.

  Show show;
  _ShowDetailState({this.show});

  @override
  void initState() {
    super.initState();

    //Called to fetch all seasons in selected TV Series
    getSeasons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: Appbars.appbarWithBackNav("Series Details"),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //First Column will have a row
            //The row contains thumbnails and season select dropdown.
            Row(
              children: [
                //TV Series thumbnail image
                Container(
                  height: Sizes.ofHeight(20),
                  width: Sizes.ofHeight(17),
                  child: show.image != ""
                      ? Image(
                          image: NetworkImage(show.image),
                        )
                      : Icon(Icons.error),
                ),

                //TV Series seasons select dropdown.
                Expanded(
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.ofWidth(2)),
                        decoration: BoxDecoration(color: Colours.accent, borderRadius: BorderRadius.circular(4)),
                        child: Consumer<Season>(builder: (context, value, child) {
                          return value.seasonsList.length > 0
                              ? DropdownButton(
                                  dropdownColor: Colours.accent,
                                  items: value.seasonsList,
                                  value: value.selectedSeason,
                                  onChanged: (val) {
                                    //onChanged called to pass the selected season
                                    value.selectSeason(val);

                                    //get all the episodes in the series
                                    getEpisodes(val);
                                  },
                                )
                              //Circular progress indicator is shown when dropdown seasons are still loading.
                              : Container(
                                  decoration: BoxDecoration(color: Colours.accent, borderRadius: BorderRadius.circular(4)),
                                  padding: EdgeInsets.all(Sizes.ofWidth(2)),
                                  child: SizedBox(
                                    height: Sizes.ofWidth(6),
                                    width: Sizes.ofWidth(6),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  ),
                                );
                        })),
                  ),
                )
              ],
            ),

            //TV Series name.
            Container(
              margin: EdgeInsets.only(top: Sizes.ofHeight(2), bottom: Sizes.ofHeight(1)),
              padding: EdgeInsets.symmetric(horizontal: Sizes.ofWidth(2)),
              child: Text(
                "${show.name}",
                style: Texts.whiteBig(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            //TV Series summary.
            Container(
              child: Material(
                color: Colours.background,
                child: InkWell(
                    onTap: () {
                      Dialogs.showSummaryDialog(context, show.summary);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: Sizes.ofHeight(1)),
                      padding: EdgeInsets.symmetric(horizontal: Sizes.ofWidth(2), vertical: Sizes.ofHeight(1)),
                      child: Text(
                        "${show.summary}",
                        style: Texts.whiteSubText(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ),
            ),

            //Progress indicator controlled by provider.
            //Progress is displayed when loading episodes for the selected season.
            Center(
                child: Container(
              margin: EdgeInsets.only(top: Sizes.ofHeight(1)),
              child: Progress.progressLoader(),
            )),

            //Episodes list for the selected seasons.
            Expanded(
                child: AnimatedSize(
              vsync: this,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: Consumer<Episode>(
                  builder: (context, value, child) => Container(
                        width: value.episodes.length > 0 ? double.infinity : 0,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: Sizes.ofWidth(4)),
                          itemCount: value.episodes.length,
                          itemBuilder: (context, index) => Cards.episodeCard(value.episodes[index]),
                        ),
                      )),
            ))
          ],
        ),
      ),
    );
  }

  getSeasons() async {
    //Called at init
    //Getting all seasons from API.
    List<Season> seasons = await Api.getSeasons(show.id);

    //Mapping all seasons to dropdown button to enable dropdown.
    seasons.forEach((element) {
      context.read<Season>().addSeason(DropdownMenuItem(
            value: element,
            child: Text(
              "Season ${element.number}",
              style: Texts.whiteSubText(),
            ),
          ));
    });

    //The first available season will be selected by default for the first time.
    context.read<Season>().selectFirstSeason();

    //Episodes will be fetched for the defualt season, which will the first available season.
    getEpisodes(context.read<Season>().selectedSeason);
  }

  getEpisodes(Season selectedSeason) async {
    //Progress indicator is loaded when episodes are getting loaded.
    context.read<Loading>().load();

    //All episodes from the selected season will be cleared.
    context.read<Episode>().clearEpisodes();

    //The new list of episodes from API will be passed to the episodes list.
    //The new list will displayed.
    context.read<Episode>().addEpisodes(await Api.getEpisodes(selectedSeason.id.toString()));

    //The progress indicator will be stopped.
    context.read<Loading>().stop();
  }
}
