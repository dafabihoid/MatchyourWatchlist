import 'package:watchlist/DTOs/FilterDTO.dart';

import '../class/FilterSettingData.dart';

class MainFilter {
  static final MainFilter _mainFilter = MainFilter._internal();

  FilterSettingData filterSettingData = FilterSettingData(
      languageId: "de",
      genreMovieIds: [],
      genreSeriesIds: [],
      mediaProviderIds: [],
      mediaTypes: ["movie", "tv"]
  );
  bool filterSettingsChanged = false;

  factory MainFilter(){
    return _mainFilter;
  }

  MainFilter._internal();

  void resetData(){
    filterSettingData = FilterSettingData(
        languageId: "de",
        genreMovieIds: [],
        genreSeriesIds: [],
        mediaProviderIds: [],
        mediaTypes: ["movie", "tv"]
    );
  }

  String getLanguage(){
    return filterSettingData.languageId;
  }

  void setLanguage(String languageId){
    filterSettingData.languageId = languageId;
  }

  void addGenreMovie (int id){
    filterSettingData.genreMovieIds.add(id);
  }

  void removeGenreMovie (int id){
    filterSettingData.genreMovieIds.remove(id);
  }

  void addGenreSeries (int id){
    filterSettingData.genreSeriesIds.add(id);
  }

  void removeGenreSeries (int id){
    filterSettingData.genreSeriesIds.remove(id);
  }

  void addMediaProvider (int id){
    filterSettingData.mediaProviderIds.add(id);
  }

  void removeMediaProvider (int id){
    filterSettingData.mediaProviderIds.remove(id);
  }

  void addMediaType (String mediaType){
    filterSettingData.mediaTypes.add(mediaType);
  }

  void removeMediaType (String mediaType){
    filterSettingData.mediaTypes.remove(mediaType);
  }

  FilterDTO toFilterDTO(){
    return FilterDTO(languageId: filterSettingData.languageId, genreMovieIds: filterSettingData.genreMovieIds, genreSeriesIds: filterSettingData.genreSeriesIds,mediaProviderIds: filterSettingData.mediaProviderIds, mediaTypes: filterSettingData.mediaTypes);
  }
}