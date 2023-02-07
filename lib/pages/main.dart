import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/AppData.dart';
import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/pages/Login/splash.dart';
import 'package:watchlist/Singleton/WatchlistSingleton.dart';
import '../Singleton/MainFilter.dart';
import '../utils/ButtonsProvider.dart';
import '../utils/CardProvider.dart';
import '../utils/SnackBar.dart';
import '../utils/myThemes.dart';
import 'package:flutter/services.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppData appData = AppData();
  MainFilter mainFilter = MainFilter();
  BackendDataProvider backendDataProvider = BackendDataProvider();
  backendDataProvider.initializeFunctions();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) =>
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CardProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => ButtonsProvider()),

        ],
      child: MyApp(),
    )
  ));
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final cardProvider = Provider.of<CardProvider>(context);

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

