import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/AppData.dart';
import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/Singleton/ListCreationFilter.dart';

import '../../Singleton/MainFilter.dart';
import '../../utils/CardProvider.dart';
import '../mainPage.dart';

class InitializingDataLoadingPage extends StatefulWidget {
  const InitializingDataLoadingPage({Key? key}) : super(key: key);

  @override
  State<InitializingDataLoadingPage> createState() => _InitializingDataLoadingPageState();

}

class _InitializingDataLoadingPageState extends State<InitializingDataLoadingPage> {
  bool initializingFinished = false;
  bool started = false;

  @override
  Widget build(BuildContext context) {
    if(!started){
      started = true;
      BackendDataProvider backendDataProvider = BackendDataProvider();
      loadFilterSettings(backendDataProvider);
      Navigatetohome(context);
    }

    return Scaffold(
      body: Center(
        child: !initializingFinished ?
          Column (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color> (Colors.deepPurpleAccent),
              )
            ],
          ) :
          MainPage(),
      ),
    );

  }

  Navigatetohome(BuildContext context) async {
    if (!mounted) {
      return;
    }
    AppData appData = AppData();
    while(!appData.filterSettingsAreAvailable) {
      await Future.delayed(const Duration(milliseconds: 500),(){});
    }
    final provider = Provider.of<CardProvider>(context, listen: false);
    provider.initializeData();
    provider.getMovies.forEach((element) {
      Future.wait([
        precacheImage(NetworkImage(element.cover), context),
      ]);
    });
    await Future.delayed(const Duration(milliseconds: 500),(){});
    initializingFinished = true;
    setState(() {});
  }

  void loadFilterSettings(BackendDataProvider backendDataProvider) async {
    while(backendDataProvider.importantProviders.isEmpty || backendDataProvider.allGenresMovies.isEmpty || backendDataProvider.allGenresSeries.isEmpty){
      await Future.delayed(const Duration(milliseconds: 300),(){});
    }
    MainFilter mainFilter = MainFilter();
    ListCreationFilter listCreationFilter = ListCreationFilter();

    mainFilter.resetData();

    backendDataProvider.allGenresMovies.forEach((element) {
      mainFilter.addGenreMovie(element.genreId);
    });
    backendDataProvider.allGenresSeries.forEach((element) {
      mainFilter.addGenreSeries(element.genreId);
    });
    backendDataProvider.importantProviders.forEach((element) {
      mainFilter.addMediaProvider(element.providerId);
    });

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
