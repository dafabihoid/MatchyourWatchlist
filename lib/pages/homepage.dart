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
    return Container(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Column(children: [
            //logo + matchyourwatchlist
            //      Container(
            //      alignment: Alignment.center,
            //       child: Image.asset(
            //      "lib/assets/logo.png",
            //       height: screenheight * 0.05,
            //     ),
            //      ),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10, top: 10),
              child: Column(children: [
                Container(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: IconButton(
                  onPressed: () {},
                    color: Colors.black,
                  icon: Icon(Icons.filter_alt_outlined),
                ),),),
                Container(
                   // margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    child: Image.asset(
                      "lib/assets/test.jpg",
                      height: screenwidth * 1.3,
                    ),
                  ),
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
