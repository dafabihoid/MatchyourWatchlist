import 'package:watchlist/class/Language.dart';
import 'package:watchlist/class/MediaProvider.dart';

import '../class/Genre.dart';

class FilterDTO{
  Language language = Language("en", "English");
  List<Genre> genres = [];
  List<MediaProvider> mediaProviders = [];
  List<String> mediaTypes = {"movie", "tv"} as List<String>;

  FilterDTO({
    required this.language,
    required this.genres,
    required this.mediaProviders,
    required this.mediaTypes
  });

  factory FilterDTO.fromJson(Map<String, dynamic> json){
    return FilterDTO(
        language: json['language'],
        genres: loadGenres(json),
        mediaProviders: loadMediaProvider(json),
        mediaTypes: loadMediaTypes(json)
    );
  }

  static List<Genre> loadGenres(Map<String, dynamic> json){
    var genreList = List.from(json['genres']).map((item) {
      if(item is Map<String, dynamic>)
      {
        return Genre.fromJson(item);
      }
    }).toList();

    return genreList.whereType<Genre>().toList();
  }

  static List<MediaProvider> loadMediaProvider(Map<String, dynamic> json) {
    var mediaProviderList = List.from(json['mediaProviders']).map((item) {
      if(item is Map<String, dynamic>)
      {
        return MediaProvider.fromJson(item);
      }
    }).toList();

    return mediaProviderList.whereType<MediaProvider>().toList();
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
}