import 'package:flutter/material.dart';
import 'package:watchlist/pages/Homepage.dart';
import 'package:watchlist/pages/Profilpage.dart';
import 'package:watchlist/pages/ListPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    ListPage(),
    HomePage(),
    ProfilPage(),
  ];
  int currentIndex = 1;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black87.withOpacity(0.8),
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        //elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined), label: "Lists"),
          BottomNavigationBarItem(
              icon: Container(
                  width: screenwidth * 0.1,
                  child: Image.asset("lib/assets/Logo.png")),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
        //Icon(Icons.home)
      ),
    );
  }
}
