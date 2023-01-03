import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/Singleton/ListCreationFilter.dart';

class FilterManager{
  static ListCreationFilter listCreationFilter = ListCreationFilter();
  static BackendDataProvider backendDataProvider = BackendDataProvider();

  static List<String> getGenreMovieNamesByGenreMovieIds(){
    List<String> nameList = [];
    backendDataProvider.allGenresMovies.forEach((element) {
      if(listCreationFilter.genreMovieIds.contains(element.genreId)){
        nameList.add(element.genreName);
      }
    });
    return nameList;
  }

  static List<String> getGenreSeriesNamesByGenreSeriesIds(){
    List<String> nameList = [];
    backendDataProvider.allGenresSeries.forEach((element) {
      if(listCreationFilter.genreSeriesIds.contains(element.genreId)){
        nameList.add(element.genreName);
      }
    });
    return nameList;
  }

  static List<String> getMediaProviderNamesByMediaProviderIds(){
    List<String> nameList = [];
    backendDataProvider.importantProviders.forEach((element) {
      if(listCreationFilter.genreSeriesIds.contains(element.providerId)){
        nameList.add(element.providerName);
      }
    });
    return nameList;
  }

  static List<String> getLanguageNamesByLanguageIds(){
    List<String> nameList = [];
    backendDataProvider.allLanguages.forEach((element) {
      if(listCreationFilter.languageId == element.languageId){
        nameList.add(element.language);
      }
    });
    return nameList;
  }

  static List<String> getMediaTypeNamesByMediaTypeIds(){
    return listCreationFilter.mediaTypes;
  }

}