import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/mainPage.dart';
import 'package:watchlist/pages/Homepage.dart';
import 'package:watchlist/pages/WelcomePage.dart';
import 'package:watchlist/pages/splash.dart';
import '../utils/CardProvider.dart';
import '../utils/SnackBar.dart';
import 'ListPage.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          scaffoldMessengerKey: Utils.SnackBarKey,
          title: 'MatchyourWatchlist',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  primary: Colors.white,
                  shape: CircleBorder(),
                  minimumSize: Size.square(60),
                )
            ),
          ),

          home: Splash(), //ListPage(),
        ));
  }
}

