import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:watchlist/class/Language.dart';

import '../DTOs/MediaDTO.dart';
import '../class/Genre.dart';
import '../class/Provider.dart';

String getBaseUrl(){
  return "http://10.0.2.2/diplo/public/tmdb";
}

Future<MediaDTO> fetchNewMovieDTO() async{
  var rng = Random();
  //für lokale api
  var response = await http.get(
    Uri.parse(
      "${getBaseUrl()}/getRandomMediaDefault"
    )
  );
  //für externe api
  //var response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/"+ rng.nextInt(2000).toString() +"?api_key=baabd94df20419bfe4e7fe9bc72dc923"));

  if (response.statusCode == 200) {
    return MediaDTO.fromJson(jsonDecode(response.body));
  } else {
    return fetchNewMovieDTO();
  }
}

Future<List<Genre>> fetchAllGenres(String mediaType) async{
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/getAllGenres/$mediaType"
      )
  );

  if (response.statusCode == 200) {
    return List<Genre>.generate(jsonDecode(response.body).length, (int index) {
      return Genre.fromJson(jsonDecode(response.body)[index]);
    });
  } else {
    return List.empty();
  }
}


Future<List<Language>> fetchAllLanguages() async{
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/getAllLanguages"
      )
  );

  if (response.statusCode == 200) {
    return List<Language>.generate(jsonDecode(response.body).length, (int index) {
      return Language.fromJson(jsonDecode(response.body)[index]);
    });
  } else {
    return List.empty();
  }
}

Future<List<Provider>> fetchImportantProvider() async{
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/getImportantProviders"
      )
  );

  if (response.statusCode == 200) {
    return List<Provider>.generate(jsonDecode(response.body).length, (int index) {
      return Provider.fromJson(jsonDecode(response.body)[index]);
    });
  } else {
    return List.empty();
  }
}