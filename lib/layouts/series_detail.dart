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
  Show show;
  _ShowDetailState({this.show});

  @override
  void initState() {
    super.initState();
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
            Row(
              children: [
                Container(
                  height: Sizes.ofHeight(20),
                  width: Sizes.ofHeight(17),
                  child: show.image != ""
                      ? Image(
                          image: NetworkImage(show.image),
                        )
                      : Icon(Icons.error),
                ),
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
                                    value.selectSeason(val);
                                    getEpisodes(val);
                                  },
                                )
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
            Center(
                child: Container(
              margin: EdgeInsets.only(top: Sizes.ofHeight(1)),
              child: Progress.progressLoader(),
            )),
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
    //context.read<Loading>().load();

    List<Season> seasons = await Api.getSeasons(show.id);
    seasons.forEach((element) {
      log("message");
      context.read<Season>().addSeason(DropdownMenuItem(
            value: element,
            child: Text(
              "Season ${element.number}",
              style: Texts.whiteSubText(),
            ),
          ));
    });
    context.read<Season>().selectFirstSeason();
    getEpisodes(context.read<Season>().selectedSeason);
  }

  getEpisodes(Season selectedSeason) async {
    context.read<Loading>().load();
    context.read<Episode>().clearEpisodes();
    context.read<Episode>().addEpisodes(await Api.getEpisodes(selectedSeason.id.toString()));
    context.read<Loading>().stop();
  }
}
