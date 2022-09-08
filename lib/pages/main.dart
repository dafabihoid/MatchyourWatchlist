import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/mainPage.dart';
import 'package:watchlist/pages/Homepage.dart';
import 'package:watchlist/pages/WelcomePage.dart';
import 'package:watchlist/pages/splash.dart';
import '../utils/CardProvider.dart';

import 'package:firebase_core/firebase_core.dart';

Future main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => testen();

  // This widget is the root of your application.



}

class testen extends State<MyApp>{
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
        create: (context) => CardProvider(),
        child:MaterialApp(
          title: 'MatchyourWatchlist',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  primary: Colors.white,
                  shape: CircleBorder(),
                  minimumSize: Size.square(60),
                )
            ),
          ),

          home: Splash(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
