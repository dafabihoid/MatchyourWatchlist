import 'package:watchlist/DTOs/FilterDTO.dart';

class ListCreationFilter {
  static final ListCreationFilter _listCreationFilter = ListCreationFilter._internal();

  String languageId = "de";
  List<int> genreMovieIds = [];
  List<int> genreSeriesIds = [];
  List<int> mediaProviderIds = [];
  List<String> mediaTypes = ["movie", "tv"];

  factory ListCreationFilter(){
    return _listCreationFilter;
  }

  void resetData(){
    languageId = "de";
    genreMovieIds = [];
    genreSeriesIds = [];
    mediaProviderIds = [];
    mediaTypes = ["movie", "tv"];
  }

  ListCreationFilter._internal();

  String getLanguage(){
    return languageId;
  }

  void setLanguage(String languageId){
    this.languageId = languageId;
  }

  void addGenreMovie (int id){
    genreMovieIds.add(id);
  }

  void removeGenreMovie (int id){
    genreMovieIds.remove(id);
  }

  void addGenreSeries (int id){
    genreSeriesIds.add(id);
  }

  void removeGenreSeries (int id){
    genreSeriesIds.remove(id);
  }

  void addMediaProvider (int id){
    mediaProviderIds.add(id);
  }

  void removeMediaProvider (int id){
    mediaProviderIds.remove(id);
  }

  void addMediaType (String mediaType){
    mediaTypes.add(mediaType);
  }

  void removeMediaType (String mediaType){
    mediaTypes.remove(mediaType);
  }

  FilterDTO toFilterDTO(){
    return FilterDTO(languageId: languageId, genreMovieIds: genreMovieIds, genreSeriesIds: genreSeriesIds,mediaProviderIds: mediaProviderIds, mediaTypes: mediaTypes);
  }
}