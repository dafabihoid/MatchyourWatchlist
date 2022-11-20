import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/Login/splash.dart';
import 'package:watchlist/utils/BackendDataProvider.dart';
import '../Singleton/MainFilter.dart';
import '../utils/CardProvider.dart';
import '../utils/SnackBar.dart';
import '../utils/myThemes.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MainFilter mainFilter = MainFilter();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CardProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => BackendDataProvider()),
        ],
      child: MyApp(),

    )
  );
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final backendDataProvider = Provider.of<BackendDataProvider>(context);
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





