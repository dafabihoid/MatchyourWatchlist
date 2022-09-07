import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/CardProvider.dart';
import 'package:watchlist/pages/Profilpage.dart';
import 'package:watchlist/pages/ListPage.dart';

import '../tinder_Card.dart';
import 'FilterPage.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {

  final movie = Movie(
    title: "Doktor Strange",
    description: "Test",
    genre: "Sci FI",
    cover: "https://de.web.img3.acsta.net/pictures/22/04/07/09/24/5141471.jpg",
  );

  List pages = [
    const ListPage(),
    const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Expanded(
                    child: buildCards(),
                  ),
              //    SizedBox(
               //     height: 10,
              //    ),
             //     buildButtons(),
                ],
              )),
        ]),
      ),
    );
  }

  void SearchButtonPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  void FilterButtonPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FilterPage()));
  }

  void LikeButtonPressed() {}

  void DisslikeButtonPressed() {}

  Widget buildButtons() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
          ElevatedButton(
            onPressed: DisslikeButtonPressed,
            child: Icon(
              Icons.clear,
              color: Colors.red,
              size: 30,
            ),
          ),
          ElevatedButton(
            onPressed: LikeButtonPressed,
            child: Icon(
              Icons.favorite,
              color: Colors.green,
              size: 30,
            ),
          ),
        ],
      );

  buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final movies = provider.movies;

    return Stack(
      children: movies
          .map((movie) => TinderCard(
          movie: movie,
          isFront: movies.last == movie,
      ))
      .toList(growable: true),

    );
  }
}

class Movie {
  final String title;
  final String genre;
  final String description;
  final String cover;

  const Movie({
    required this.title,
    required this.genre,
    required this.description,
    required this.cover,
  });
}
