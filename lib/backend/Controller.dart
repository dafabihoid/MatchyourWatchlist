import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../DTOs/MediaDTO.dart';

Future<MediaDTO> fetchNewMovieDTO() async{
  var rng = Random();
  //für lokale api
  var response = await http.get(
    Uri.parse(
      "http://10.0.2.2/diplo/public/tmdb/getRandomMedia"
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
