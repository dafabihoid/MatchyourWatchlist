import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watchlist/DTOs/FilterDTO.dart';
import 'package:watchlist/Singleton/AppData.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/class/Language.dart';

import '../DTOs/ListWithMediaDTO.dart';
import '../DTOs/MediaDTO.dart';
import '../class/Genre.dart';
import '../class/MediaProvider.dart';

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

  if (response.statusCode == 200) {
    if(response.body == "error_no_media_available"){
      /*
       * hier muss für den fall das wegen den filter kein film gefunden werden kann ein failsafe eingebaut werden
       */
      throw Exception("no media found with this settings");
    }
    if(response.body == "error_no_connection"){
      throw Exception("no successful connection to TheMovieDatabase");
    }
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
    await Future.delayed(const Duration(milliseconds: 1000),(){});
    return fetchNewFilterDTO(userId);
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

Future<void> createNewUserWithDetails(userId, userName) async{
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/createNewUserWithDetails/$userId/$userName"
      )
  );
}

Future<void> addMediaToWatchlist(MediaDTO mediaDTO) async{
  var json = mediaDTO.toJson();
  AppData appData = AppData();
  print("${getBaseUrl()}/addMediaToWatchlist/${appData.mainListId}/${jsonEncode(json)}/${appData.appLanguage}");
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/addMediaToWatchlist/${appData.mainListId}/${jsonEncode(json)}/${appData.appLanguage}"
      )
  );
}

Future<void> transferMediaBetweenWatchLists(ListWithMediaDTO listWithMediaDTO) async{
  var json = listWithMediaDTO.toJson();
  AppData appData = AppData();
  print("${getBaseUrl()}/transferMediaBetweenWatchLists/${jsonEncode(json)}/${appData.appLanguage}");
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/transferMediaBetweenWatchLists/${jsonEncode(json)}/${appData.appLanguage}"
      )
  );
}

Future<String> getUserNameByUserId() async{
  AppData appData = AppData();
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/getRandomMedia/${appData.userId}"
      )
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return "user not found";
  }
}

Future<List<ListWithMediaDTO>> fetchAllWatchlistsForUser() async{
  AppData appData = AppData();
  String str = "${getBaseUrl()}/loadPersonalWatchlistDataForUser/${appData.userId}";
  var response = await http.get(
      Uri.parse(
          "${getBaseUrl()}/loadPersonalWatchlistDataForUser/${appData.userId}"
      )
  );

  if (response.statusCode == 200) {
    return List<ListWithMediaDTO>.generate(jsonDecode(response.body).length, (int index) {
      return ListWithMediaDTO.fromJson(jsonDecode(response.body)[index]);
    });
  } else {
    return List.empty();
  }
}
