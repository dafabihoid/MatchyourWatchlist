import 'package:flutter/material.dart';
import 'package:watchlist/pages/Homepage.dart';
import 'package:watchlist/pages/main.dart';
import '../../class/Movie.dart';

enum CardStatus { like, dislike }

class CardProvider extends ChangeNotifier {
  List<Movie> movies = [];
  bool isMoving = false;
  Offset position = Offset.zero;
  Size screenSize = Size.zero;
  double angle = 0;

  List<Movie> get Getmovies => movies;

  bool get Getismoved => isMoving;

  Offset get Getposition => position;

  double get GetAngle => angle;

  CardProvider() {
    resetUser();
  }

  void setScreenSize(Size getscreenSize) => screenSize = getscreenSize;

  void startPosition(DragStartDetails details) {
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
    if (movies.length < 3) {
      movies.insert(
          0,
          const Movie(
              title: "Test Test",
              genre: "Fantasy",
              description: "Test",
              cover:
                  "https://de.web.img3.acsta.net/pictures/22/04/07/09/24/5141471.jpg"));
      movies.insert(
          1,
          const Movie(
              title: "König der Löwen",
              genre: "Tiere",
              description: "Test",
              cover:
                  "https://static.wikia.nocookie.net/koenigderloewen/images/a/a5/DerKoenigDerLoewen_poster_02.jpg/revision/latest?cb=20140626201338&path-prefix=de"));
    }
  }

  void resetUser() {
    movies = <Movie>{
      const Movie(
          title: "Doktor Strange",
          genre: "Fantasy",
          description: "Test",
          cover:
              "https://de.web.img3.acsta.net/pictures/22/04/07/09/24/5141471.jpg"),
      const Movie(
          title: "Findet Nemo",
          genre: "Test",
          description: "Test",
          cover:
              "https://static.wikia.nocookie.net/disney/images/6/6b/Findet_Nemo.jpg/revision/latest/top-crop/width/360/height/450?cb=20141231155627&path-prefix=de"),
      const Movie(
          title: "König der Löwen",
          genre: "Tiere",
          description: "Test",
          cover:
              "https://static.wikia.nocookie.net/koenigderloewen/images/a/a5/DerKoenigDerLoewen_poster_02.jpg/revision/latest?cb=20140626201338&path-prefix=de"),
    }.toList(growable: true);

    notifyListeners();
  }

  CardStatus? getStatus() {
    final xCoordinate = position.dx;
    const distanzLike = 100;
    const distanzDislike = -100;

    if (xCoordinate >= distanzLike) {
      return CardStatus.like;
    } else if (xCoordinate <= distanzDislike) {
      return CardStatus.dislike;
    }
  }

  void liked() {
    angle = 20;
    position += Offset(screenSize.width * 2, 0);
    deleteCard();

    notifyListeners();
  }

  void disliked() {
    angle = -20;
    position -= Offset(screenSize.width * 2, 0);
    deleteCard();

    notifyListeners();
  }

  void deleteCard() async {
    if (Getmovies.isEmpty) return;

    await Future.delayed(Duration(milliseconds: 200));
    // HIER KANN MAN NEUE FILME EINFÜGEN!!!!
    Getmovies.removeLast();

    resetPosition();
  }
}
