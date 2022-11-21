import 'package:flutter/material.dart';

import 'package:watchlist/class/Language.dart';
import '../../class/Genre.dart';
import '../../class/MediaProvider.dart';
import '../backend/Controller.dart';


class BackendDataProvider extends ChangeNotifier {
  List<Genre> allGenresMovies = [];
  List<Genre> allGenresSeries = [];
  List<Language> allLanguages = [];
  List<MediaProvider> importantProviders = [];

  BackendDataProvider(){
   initializeFunctions();
  }

  void initializeFunctions() {
    loadAllGenresMovies("movie");
    loadAllGenresMovies("tv");
    loadAllLanguages();
    loadImportantProviders();
  }

  /*
  void initializeFunctions() async {
    await loadAllGenresMovies("movie");
    await loadAllGenresMovies("tv");
    await loadAllLanguages();
    await loadImportantProviders();
  }
   */

  Future<bool> loadAllGenresMovies(String mediaType) async{
    Future<List<Genre>> futureGenres = fetchAllGenres(mediaType);
    futureGenres.then((result) {
      for (Genre genre in result) {
        if (mediaType == "movie") {
          allGenresMovies.add(genre);
        }
        else {
          allGenresSeries.add(genre);
        }
      }
    });
    return true;
  }

  Future<bool> loadAllLanguages() async{
    Future<List<Language>> futureLanguages = fetchImportantLanguages();
    futureLanguages.then((result) {
      for (Language language in result) {
        allLanguages.add(language);
      }
    });
    return true;
  }

  Future<bool> loadImportantProviders() async{
    Future<List<MediaProvider>> futureProviders = fetchImportantProvider();
    futureProviders.then((result) {
      for (MediaProvider provider in result) {
        importantProviders.add(provider);
      }
    });
    return true;
  }

}

