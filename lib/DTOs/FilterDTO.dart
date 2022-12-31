import 'package:watchlist/class/Language.dart';
import 'package:watchlist/class/MediaProvider.dart';

import '../class/Genre.dart';

class FilterDTO{
  String languageId = "de";
  List<int> genreMovieIds = [];
  List<int> genreSeriesIds = [];
  List<int> mediaProviderIds = [];
  List<String> mediaTypes = ["movie", "tv"];

  FilterDTO({
    required this.languageId,
    required this.genreMovieIds,
    required this.genreSeriesIds,
    required this.mediaProviderIds,
    required this.mediaTypes
  });

  factory FilterDTO.fromJson(Map<String, dynamic> json){
    return FilterDTO(
        languageId: json['languageId'],
        genreMovieIds: loadGenreMovieIds(json),
        genreSeriesIds: loadGenreSeriesIds(json),
        mediaProviderIds: loadMediaProviderIds(json),
        mediaTypes: loadMediaTypes(json)
    );
  }

  static List<int> loadGenreMovieIds(Map<String, dynamic> json){
    var genreList = List.from(json['genreMovieIds']).map((item) {
      if(item is int)
      {
        return item;
      }
    }).toList();

    return genreList.whereType<int>().toList();
  }

  static List<int> loadGenreSeriesIds(Map<String, dynamic> json){
    var genreList = List.from(json['genreSeriesIds']).map((item) {
      if(item is int)
      {
        return item;
      }
    }).toList();

    return genreList.whereType<int>().toList();
  }

  static List<int> loadMediaProviderIds(Map<String, dynamic> json) {
    var mediaProviderList = List.from(json['mediaProviderIds']).map((item) {
      if(item is int)
      {
        return item;
      }
    }).toList();

    return mediaProviderList.whereType<int>().toList();
  }

  static List<String> loadMediaTypes(Map<String, dynamic> json) {
    var mediaTypesList = List.from(json['mediaTypes']).map((item) {
      if(item is String)
      {
        return item;
      }
    }).toList();

    return mediaTypesList.whereType<String>().toList();
  }

  Map<String, dynamic> toJson() => {
    'languageId': languageId,
    'genreMovieIds': genreMovieIds,
    'genreSeriesIds': genreSeriesIds,
    'mediaProviderIds': mediaProviderIds,
    'mediaTypes': mediaTypes,
  };
}
