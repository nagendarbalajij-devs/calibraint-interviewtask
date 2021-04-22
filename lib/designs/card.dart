import 'package:flutter/material.dart';
import 'package:interviewtask/designs/buttons.dart';
import 'package:interviewtask/designs/colours.dart';
import 'package:interviewtask/designs/progress.dart';
import 'package:interviewtask/designs/texts.dart';
import 'package:interviewtask/models/episode.dart';
import 'package:interviewtask/models/show.dart';
import 'package:interviewtask/utils/dialogs.dart';
import 'package:interviewtask/utils/sizes.dart';

class Cards {
  //Card to display TV Series
  //Contains thumbnail images, title, summary
  static Widget showCard(context, Show show, var showDetail) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.ofHeight(1)),
      padding: EdgeInsets.all(Sizes.ofHeight(1)),
      decoration: BoxDecoration(
        color: Colours.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Thumbnail image
          Container(
              height: Sizes.ofHeight(12),
              width: Sizes.ofHeight(9),
              child: show.image != ""
                  ? Image(
                      image: NetworkImage(show.image),
                      loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null ? child : Progress.progressIndicator();
                      },
                    )
                  : Icon(Icons.error)),

          Container(
            margin: EdgeInsets.only(left: Sizes.ofWidth(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TV Series name
                Container(
                  width: Sizes.ofWidth(60),
                  child: Text(
                    "${show.name}",
                    style: Texts.white(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                //TV Series summary.
                //Will open a dialog for detailed summary when clicked on.
                Material(
                  color: Colours.primary,
                  child: InkWell(
                    onTap: () {
                      Dialogs.showSummaryDialog(context, show.summary);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: Sizes.ofHeight(1)),
                      width: Sizes.ofWidth(60),
                      child: Text(
                        "${show.summary}",
                        style: Texts.greySubText(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),

                //Show episodes button
                Container(
                    margin: EdgeInsets.only(top: Sizes.ofHeight(1)),
                    child: Buttons.button("Show Episodes", () {
                      showDetail(show);
                    })),
              ],
            ),
          )
        ],
      ),
    );
  }

  //No data available card when no results are found for search
  static Widget noDataCard() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: Sizes.ofHeight(1)),
        padding: EdgeInsets.all(Sizes.ofHeight(1)),
        decoration: BoxDecoration(
          color: Colours.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            "No data available",
            style: Texts.whiteSubText(),
          ),
        ));
  }

  //Episode display in card view.
  //Contains thumbnail image, release date and runtime.
  static Widget episodeCard(Episode episode) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.ofHeight(1)),
      padding: EdgeInsets.all(Sizes.ofHeight(1)),
      decoration: BoxDecoration(
        color: Colours.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Sizes.ofHeight(9),
            width: Sizes.ofHeight(12),
            child: episode.image != ""
                ? Image(
                    image: NetworkImage(episode.image),
                  )
                : Icon(Icons.error),
          ),
          Container(
            margin: EdgeInsets.only(left: Sizes.ofWidth(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Sizes.ofWidth(56),
                  child: Text(
                    "${episode.name}",
                    style: Texts.white(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Sizes.ofHeight(1)),
                  width: Sizes.ofWidth(56),
                  child: Text(
                    "${episode.runtime} M",
                    style: Texts.whiteSubText(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: Sizes.ofWidth(56),
                  child: Text(
                    "${episode.airdate}",
                    style: Texts.greySubText(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
