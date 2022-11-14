import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/mainPage.dart';
import 'package:watchlist/pages/Homepage/Homepage.dart';
import 'package:watchlist/pages/Login/WelcomePage.dart';
import 'package:watchlist/pages/Login/splash.dart';
import 'package:watchlist/utils/Theme.dart';
import '../utils/CardProvider.dart';
import '../utils/SnackBar.dart';
import '../utils/myThemes.dart';
import 'Watchlist/ListPage.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CardProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
      child: MyApp(),

    )
  );
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(

      scaffoldMessengerKey: Utils.SnackBarKey,
      title: 'MatchyourWatchlist',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,

      home: Splash(), //ListPage(),
    );
  }
      }





