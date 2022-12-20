import 'package:watchlist/class/Language.dart';
import '../../class/Genre.dart';
import '../../class/MediaProvider.dart';
import '../backend/Controller.dart';


class BackendDataProvider {
  static final BackendDataProvider _backendDataProvider = BackendDataProvider._internal();

  factory BackendDataProvider(){
    return _backendDataProvider;
  }

  BackendDataProvider._internal();

  List<Genre> allGenresMovies = [];
  List<Genre> allGenresSeries = [];
  List<Language> allLanguages = [];
  List<MediaProvider> importantProviders = [];

  void initializeFunctions() async{
    loadAllGenresMovies("movie");
    loadAllGenresMovies("tv");
    loadAllLanguages();
    loadImportantProviders();
  }

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

