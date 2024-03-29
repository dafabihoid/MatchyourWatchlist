import 'package:http/http.dart';

import '../class/Genre.dart';
import '../class/MediaProvider.dart';

class MediaDTO {
  final int mediaId;
  final String description;
  final String title;
  final String posterPath;
  final List<dynamic> genres;
  final List<dynamic> provider;
  final double rating;
  final String mediaType;

  const MediaDTO({
    required this.mediaId,
    required this.description,
    required this.title,
    required this.posterPath,
    required this.genres,
    required this.provider,
    required this.rating,
    required this.mediaType
  });

  factory MediaDTO.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false){
      //request failed
    }
    var genreList = List.from(json['genres']).map((item) {
      if(item is Map<String, dynamic>)
      {
        return Genre.fromJson(item);
      }
    }).toList();

    return MediaDTO(
      mediaId: json['mediaId'],
      description: getDescription(json['description']),
      title: json['title'],
      posterPath: getPosterPath(json['posterPath']),
      genres: genreList,
      provider: getProvider(json),
      rating: json['rating']+0.0,
      mediaType: json['mediaType']
    );
  }

  String output(){
    return "movieId: $mediaId title: $title poster: $posterPath raiting: $rating description: $description genre " + genres.toString();
  }

  static String getDescription(String description){
    return description.replaceAll("?", ".");
  }

  static String getPosterPath(String posterPath) {
    if (posterPath == "default") {
      return "https://media.comicbook.com/files/img/default-movie.png";
    }
    return "https://image.tmdb.org/t/p/w500" + posterPath;
  }

  static List getProvider(Map<String, dynamic> json) {
    var providerList;
    if(json['provider'] == null){
      providerList = List.empty();
    }
    else {
      providerList = List.from(json['provider']).map((item) {

        if(item is Map<String, dynamic>)
        {
          return MediaProvider.fromJson(item);
        }
      }).toList();
    }
    return providerList;
  }

  Map<String, dynamic> toJson() => {
    'mediaId': mediaId,
    'description': description,
    'title': title,
    'posterPath': posterPathToJson(),
    'genres': varToJson(genres),
    'provider': varToJson(provider),
    'rating': rating,
    'mediaType': mediaType,
  };

  List<Map<String, dynamic>> varToJson(variable) {
    List<Map<String, dynamic>> jsonVariable = [];
    variable.forEach((element) {
      jsonVariable.add(element.toJson());
    });
    return jsonVariable;
  }

  String posterPathToJson(){
    return posterPath.split("/").last;
  }
}