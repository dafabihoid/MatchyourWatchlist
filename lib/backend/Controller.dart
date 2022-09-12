import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;



Future<MovieDTO> fetchMovieDTO() async{
  var rng = Random();
  //var time = DateTime.now().millisecondsSinceEpoch;
  //print(0);
  var response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/"+ rng.nextInt(2000).toString() +"?api_key=baabd94df20419bfe4e7fe9bc72dc923"));
  //print(DateTime.now().millisecondsSinceEpoch-time);


  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return MovieDTO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return fetchMovieDTO();
  }

}

class MovieDTO {
  final int movieId;
  final String description;
  final String title;
  final String posterPath;
  final List<dynamic> genres;
  final double rating;

  const MovieDTO({
    required this.movieId,
    required this.description,
    required this.title,
    required this.posterPath,
    required this.genres,
    required this.rating,
  });

  factory MovieDTO.fromJson(Map<String, dynamic> json) {
    if (json['success'] == false){
      //request failed

    }
    var genreList = List.from(json['genres']).map((item) {
      if(item is Map<String, dynamic>)
      {
        return Genre.fromJson(item);
      }
    }).toList();

    return MovieDTO(
      movieId: json['id'],
      description: json['overview'],
      title: json['original_title'],
      posterPath: "https://image.tmdb.org/t/p/w500" + json['poster_path'],
      genres: genreList,
      rating: json['popularity'],
    );
  }

  String output(){
    return "movieId: $movieId title: $title poster: $posterPath raiting: $rating description: $description genre " + genres.toString();
  }
}

class Genre {
  late int genreId;
  late String genreName;

  Genre (String name, int id){
    genreName = name;
    genreId = id;
  }

  Genre.fromJson(Map<String, dynamic> json)
      : genreId = json['id'],
        genreName = json['name'];

  Map<String, dynamic> toJson() => {
    'genreId': genreId,
    'genreName': genreName,
  };

}