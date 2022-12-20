import 'package:flutter/material.dart';
import 'package:watchlist/backend/Controller.dart';
import 'package:watchlist/class/MediaProvider.dart';
import '../../class/Media.dart';
import '../DTOs/MediaDTO.dart';
import '../class/Genre.dart';

enum CardStatus { like, dislike }


class CardProvider extends ChangeNotifier {
  List<Media> movies = [];
  bool isMoving = false;
  Offset position = Offset.zero;
  Size screenSize = Size.zero;
  double angle = 0;
  List<Media> tempMovies = [];

  List<Media> get getMovies => movies;
  bool get getIsMoving => isMoving;
  Offset get getPosition => position;
  double get getAngle => angle;


  CardProvider();

  void initializeData() async{
    bufferMovies();
    resetUser();
  }

  void setScreenSize(Size getscreenSize) => screenSize = getscreenSize;

  void resetCardProvider(){
    removeListener(() { });
  }

  void startPosition(DragStartDetails details) {
    if (tempMovies.length<10)
    {
      bufferMovies();
    }
    isMoving = true;
  }

  void updatePosition(DragUpdateDetails details) {
    position += details.delta;


    final xCoordinate = position.dx;
    angle = 45 * xCoordinate / screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    isMoving = false;
    notifyListeners();

    final status = getStatus();

    switch (status) {
      case CardStatus.like:
        liked();
        break;
      case CardStatus.dislike:
        disliked();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    isMoving = false;
    angle = 0;
    position = Offset.zero;
    notifyListeners();
  }

  void fetchMovie () {
    Future<MediaDTO> futureMovieDTO = fetchNewMovieDTO();
    futureMovieDTO.then((result) {
      String tempGenres = "";
      String tempProviders = "";
      for (Genre element in result.genres) {
        if (element == result.genres[0]){
          tempGenres = element.genreName;
          continue;
        }
        tempGenres = "$tempGenres, " + element.genreName;
      }
      for (MediaProvider element in result.provider) {
        if (element == result.genres[0]){
          tempProviders = element.providerName;
          continue;
        }
        tempProviders = "$tempProviders, " + element.providerName;
      }
      tempMovies.insert(0,Media(id: result.mediaId,title: result.title,genres: tempGenres, providers: tempProviders, description: result.description, cover: result.posterPath, mediaType: result.mediaType));
    });
  }

  void bufferMovies () {
    fetchMovie();
    fetchMovie();
    fetchMovie();
    fetchMovie();
  }

  void resetUser() async {
    movies = <Media>{

    }.toList(growable: true);

    while (tempMovies.length < 2){
      await Future.delayed(const Duration(milliseconds: 1000));
      fetchMovie();
    }

    movieListUpdate();
    movieListUpdate();

    //notifyListeners();
  }

  CardStatus? getStatus() {
    final xCoordinate = position.dx;
    const distanceLike = 100;
    const distanceDislike = -100;

    if (xCoordinate >= distanceLike) {
      return CardStatus.like;
    } else if (xCoordinate <= distanceDislike) {
      return CardStatus.dislike;
    }
  }

  void liked() {
    angle = 20;

    position += Offset(screenSize.width * 2, 0);
    deleteCard();
    print("like");
    notifyListeners();
  }

  void disliked() {
    angle = -20;
    position -= Offset(screenSize.width * 2, 0);
    deleteCard();

    notifyListeners();
  }

  void deleteCard() async {
    await Future.delayed(const Duration(milliseconds: 200));

    resetPosition();
    print(movies.length.toString());

    if (movies.isNotEmpty){
      movies.removeLast();
    }

    while (tempMovies.length < 2){
      await Future.delayed(const Duration(milliseconds: 400));
      fetchMovie();
    }

    if (movies.length < 5) {
      movieListUpdate();
      movieListUpdate();
    }
  }

  void movieListUpdate(){
    movies.insert(0, Media(id: tempMovies.last.id, title: tempMovies.last.title, genres: tempMovies.last.genres, providers: tempMovies.last.providers, description: tempMovies.last.description, cover: tempMovies.last.cover, mediaType: tempMovies.last.mediaType));
    tempMovies.removeLast();
  }
}