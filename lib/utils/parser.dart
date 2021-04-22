import 'package:html/parser.dart';

class SummaryParser {
  //The summary from API contains HTML tags.
  //This will be used to remove the html tags and return the String.
  static String parseSummary(String summary) {
    var res = parse(summary);
    return parse(res.body.text).documentElement.text;
  }
}
