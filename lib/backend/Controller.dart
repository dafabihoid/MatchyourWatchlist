import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:watchlist/DTOs/FilterDTO.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/class/Language.dart';

import '../DTOs/MediaDTO.dart';
import '../class/Genre.dart';
import '../class/MediaProvider.dart';

/**
 * bei main beim laden der filtereinstellungen einen lade kreis anzeigen bis laden fertig ist
 * fertig für laden über simpelton in variable speichern und checken über gleiche methode wie bei filter laden
 */

String getBaseUrl(){
  //return "http://10.0.2.2/diplo/public/tmdb";
  return "http://185.208.206.99/diplo/matchyourwatchlist/tmdb";
}

Future<MediaDTO> fetchNewMovieDTO() async{
  var json = MainFilter().toFilterDTO().toJson();
  print(jsonEncode(json));
  var response = await http.get(
    Uri.parse(
      "${getBaseUrl()}/getRandomMedia/${jsonEncode(json)}"
    )
  );

  /*für externe api
  var rng = Random();
  var response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/"+ rng.nextInt(2000).toString() +"?api_key=baabd94df20419bfe4e7fe9bc72dc923"));*/

  if (response.statusCode == 200) {
    return MediaDTO.fromJson(jsonDecode(response.body));
  } else {
    return fetchNewMovieDTO();
  }
}

Future<FilterDTO?> fetchNewFilterDTO(String userId) async{
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/getFilterById/$userId"
      )
  );

  if (response.statusCode == 200) {
    return FilterDTO.fromJson(jsonDecode(response.body));
  } else {
    return null;
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

Future<List<Language>> fetchImportantLanguages() async{
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/getImportantLanguages"
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

Future<List<MediaProvider>> fetchImportantProvider() async{
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/getImportantProviders"
      )
  );

  if (response.statusCode == 200) {
    return List<MediaProvider>.generate(jsonDecode(response.body).length, (int index) {
      return MediaProvider.fromJson(jsonDecode(response.body)[index]);
    });
  } else {
    return List.empty();
  }
}
