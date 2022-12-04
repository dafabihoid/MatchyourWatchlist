import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/AppData.dart';
import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/Singleton/ListCreationFilter.dart';
import 'package:watchlist/pages/Login/splash.dart';
import '../Singleton/MainFilter.dart';
import '../utils/CardProvider.dart';
import '../utils/SnackBar.dart';
import '../utils/myThemes.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppData appData = AppData();
  MainFilter mainFilter = MainFilter();
  BackendDataProvider backendDataProvider = BackendDataProvider();
  backendDataProvider.initializeFunctions();
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
    BackendDataProvider backendDataProvider = BackendDataProvider();
    loadFilterSettings(backendDataProvider);

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

  void loadFilterSettings(BackendDataProvider backendDataProvider) async {
    MainFilter mainFilter = MainFilter();
    ListCreationFilter listCreationFilter = ListCreationFilter();
    if(backendDataProvider.importantProviders.isEmpty || backendDataProvider.allGenresMovies.isEmpty || backendDataProvider.allGenresSeries.isEmpty){
      await Future.delayed(const Duration(milliseconds: 300),(){});
      loadFilterSettings(backendDataProvider);
      return;
    }
    backendDataProvider.allGenresMovies.forEach((element) {
      mainFilter.addGenreMovie(element.genreId);
    });
    backendDataProvider.allGenresSeries.forEach((element) {
      mainFilter.addGenreSeries(element.genreId);
    });
    backendDataProvider.importantProviders.forEach((element) {
      mainFilter.addMediaProvider(element.providerId);
    });
    mainFilter.genreMovieListIncludesAll = true;
    mainFilter.genreSeriesListIncludesAll = true;

    backendDataProvider.allGenresMovies.forEach((element) {
      listCreationFilter.addGenreMovie(element.genreId);
    });
    backendDataProvider.allGenresSeries.forEach((element) {
      listCreationFilter.addGenreSeries(element.genreId);
    });
    backendDataProvider.importantProviders.forEach((element) {
      listCreationFilter.addMediaProvider(element.providerId);
    });

    AppData appData = AppData();
    appData.filterSettingsAreAvailable = true;
  }
}

