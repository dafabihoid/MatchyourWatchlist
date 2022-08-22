import 'package:flutter/material.dart';
import 'package:watchlist/pages/profilpage.dart';
import 'package:watchlist/pages/searchpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    List pages = [
      SearchPage(),
      ProfilPage(),

    ];
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
       selectedItemColor: Colors.black87.withOpacity(0.8),
       unselectedItemColor: Colors.grey.withOpacity(0.5),
       showSelectedLabels: true,
       showUnselectedLabels: false,
       //elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: "Lists"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),

      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Column(children: [
                  //logo + matchyourwatchlist
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                    "lib/assets/logo.png",
                    height: screenheight * 0.05,
                  ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                      child: Image.asset(
                      "lib/assets/test.jpg",
                      height: screenwidth * 1.335,
                    ),
                    )
                  ),

                ]),

            ),
      ),
    );
  }
}
