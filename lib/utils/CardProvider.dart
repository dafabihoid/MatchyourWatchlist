import 'package:flutter/material.dart';
import 'package:watchlist/backend/Controller.dart';
import '../../class/Movie.dart';
import '../DTOs/MediaDTO.dart';
import '../class/Genre.dart';

enum CardStatus { like, dislike }


class CardProvider extends ChangeNotifier {
  List<Movie> movies = [];
  bool isMoving = false;
  Offset position = Offset.zero;
  Size screenSize = Size.zero;
  double angle = 0;
  List<Movie> tempMovies = [];

  List<Movie> get getMovies => movies;

  bool get getIsMoving => isMoving;

  Offset get getPosition => position;

  double get getAngle => angle;

  CardProvider() {
    bufferMovies();
    resetUser();
  }

  void setScreenSize(Size getscreenSize) => screenSize = getscreenSize;

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
      for (Genre element in result.genres) {
        if (element == result.genres[0]){
          tempGenres = element.genreName;
          continue;
        }
        tempGenres = "$tempGenres, " + element.genreName;
      }
      tempMovies.insert(0,Movie(title: result.title,genre: tempGenres, description: result.description, cover: result.posterPath));
    });
  }

  void bufferMovies () {
    fetchMovie();
    fetchMovie();
    fetchMovie();
    fetchMovie();
  }

  void resetUser() async {
    movies = <Movie>{

    }.toList(growable: true);

    while (tempMovies.length < 2){
      await Future.delayed(const Duration(milliseconds: 1000));
      fetchMovie();
    }

    movieListUpdate();
    movieListUpdate();

    notifyListeners();
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
    movies.insert(0, Movie(title: tempMovies.last.title, genre: tempMovies.last.genre, description: tempMovies.last.description, cover: tempMovies.last.cover));
    tempMovies.removeLast();
  }
}