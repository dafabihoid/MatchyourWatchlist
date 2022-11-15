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
   loadAllGenresMovies("movie");
   loadAllGenresMovies("tv");
   loadAllLanguages();
   loadImportantProviders();
  }

  void loadAllGenresMovies(String mediaType){
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
  }

  void loadAllLanguages(){
    Future<List<Language>> futureLanguages = fetchAllLanguages();
    futureLanguages.then((result) {
      for (Language language in result) {
        allLanguages.add(language);
      }
    });
  }

  void loadImportantProviders(){
    Future<List<MediaProvider>> futureProviders = fetchImportantProvider();
    futureProviders.then((result) {
      for (MediaProvider provider in result) {
        importantProviders.add(provider);
      }
    });
  }

}

