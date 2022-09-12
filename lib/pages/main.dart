import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/mainPage.dart';
import 'package:watchlist/pages/Homepage.dart';
import 'package:watchlist/pages/WelcomePage.dart';
import 'package:watchlist/pages/splash.dart';
import '../utils/CardProvider.dart';
import 'ListPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();

  // This widget is the root of your application.



}

class _MyApp extends State<MyApp>{
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

          home:Splash(), //ListPage(),
        ));
  }
}

