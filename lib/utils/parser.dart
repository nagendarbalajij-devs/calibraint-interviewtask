import 'package:html/parser.dart';

class SummaryParser {
  static String parseSummary(String summary) {
    var doc = parse(summary);
    return parse(doc.body.text).documentElement.text;
  }
}
