import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interviewtask/layouts/dashboard.dart';
import 'package:interviewtask/layouts/search.dart';
import 'package:interviewtask/models/episode.dart';
import 'package:interviewtask/models/loading.dart';
import 'package:interviewtask/models/season.dart';
import 'package:interviewtask/models/show.dart';
import 'package:interviewtask/models/strings.dart';
import 'package:interviewtask/utils/sizes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Provider for changing text strings
        ChangeNotifierProvider(
          create: (context) => Strings(),
        ),

        //Provider for TV Series
        ChangeNotifierProvider(
          create: (context) => Show(),
        ),

        //Provider for Seasons for a TV Series
        ChangeNotifierProvider(
          create: (context) => Season(),
        ),

        //Provider for Episodes of a season
        ChangeNotifierProvider(
          create: (context) => Episode(),
        ),

        //Provider for showing/stopping circular progress indicator
        ChangeNotifierProvider(
          create: (context) => Loading(),
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {'/search': (context) => Search()},
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Landing(),
      ),
    );
  }
}

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //To initialise screen sizes
    //Futurther called to render adaptive widgets
    Sizes(context: context).initSize();

    return Dashboard();
  }
}
