import '../class/Genre.dart';
import '../class/Provider.dart';

class MediaDTO {
  final int movieId;
  final String description;
  final String title;
  final String posterPath;
  final List<dynamic> genres;
  final List<dynamic> provider;
  final double rating;
  final String mediaType;

  const MediaDTO({
    required this.movieId,
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

    var providerList = List.from(json['provider']).map((item) {
      if(item is Map<String, dynamic>)
      {
        return Provider.fromJson(item);
      }
    }).toList();

    return MediaDTO(
      movieId: json['mediaId'],
      description: json['description'],
      title: json['title'],
      posterPath: getPosterPath(json['posterPath']),
      genres: genreList,
      provider: providerList,
      rating: json['rating']+0.0,
      mediaType: json['mediaType']
    );
  }

  String output(){
    return "movieId: $movieId title: $title poster: $posterPath raiting: $rating description: $description genre " + genres.toString();
  }

  /**
   * muss getestet werden ob default geht
   * default kommt bei mediaId 647
   */
  static String getPosterPath(String posterPath) {
    if (posterPath == "default") {
      return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7n9ShRlFcmM9X22DSHtblI35-XXJb7ekYgyO-y6t5Aw&s";
    }
    return "https://image.tmdb.org/t/p/w500" + posterPath;
  }
}