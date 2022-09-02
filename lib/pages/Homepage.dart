import 'package:flutter/material.dart';
import 'package:watchlist/pages/Profilpage.dart';
import 'package:watchlist/pages/ListPage.dart';

import 'FilterPage.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  double ContainerHeight = 110;
  double whichState = 1;
  double TitleSize = 25;
  double GenreSize = 18;
  double FontSizeHelper3 = 0;

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    List pages = [
      const ListPage(),
      const ProfilPage(),
    ];

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 24,
              child: Container(
                width: double.maxFinite,
                height: 590,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/assets/test.jpg"),
                        fit: BoxFit.cover)),
              )),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onVerticalDragEnd: (DragEndDetails details) {
                setState(() {
                  if (details.primaryVelocity! < 0) {
                    // if User swipes up -> give more details
                      if(whichState == 1){
                        ContainerHeight += 280;
                        whichState = 2;
                        FontSizeHelper3 = 18;
                      }
                      else if(whichState == 0){
                        ContainerHeight += 77;
                        whichState = 1;
                        TitleSize = 25;
                        GenreSize = 18;

                      }
                      else if(whichState == 2){}

                  } else if (details.primaryVelocity! > 0) {
                    // if User swipes down -> show cover
                    if(whichState == 1){
                      ContainerHeight -= 77;
                      whichState = 0;
                      TitleSize = 0;
                      GenreSize = 0;
                    }
                    else if(whichState == 0){
                    }
                    else if(whichState == 2){
                      ContainerHeight -= 280;
                      whichState = 1;
                      FontSizeHelper3 = 0;
                    }
                  }
                });
              },
              child: Column(
                children:[
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                width: screenwidth,
                height: ContainerHeight,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Doktor Strange: Madness of Multiverse",
                          style: TextStyle(
                            fontSize: TitleSize,
                          ),
                        )),
                    Container(
                        alignment: Alignment.centerLeft,

                        child: Text(
                          "Fantasie, Sci Fi",
                          style: TextStyle(fontSize: GenreSize, color: Colors.black45),
                        )),
                    Container(
                        margin: EdgeInsets.only(top:10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Fabian, Erik, Kristina und 4 weiteren gefällt dieses Werk ebenfalls",
                          style: TextStyle(fontSize: FontSizeHelper3, color: Colors.lightBlue),
                        )),
                  ],
                ),
              ),

                  Container(  //Buttons
                      color: Colors.white,
                      width: screenwidth,
                      height: 111,
                      child: Container(
                        padding: EdgeInsets.all(20),
                      //    margin: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.grey,
                                child: IconButton(
                                  onPressed: () {
                                    DisslikeButtonPressed();
                                  },
                                  color: Colors.black,
                                  icon: const Icon(Icons.cancel),
                                ),
                              ),

                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(left: screenwidth - 180),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.grey,
                                    child: IconButton(
                                      onPressed: () {
                                        LikeButtonPressed();
                                      },
                                      color: Colors.black,
                                      icon: const Icon(Icons.favorite_outlined),
                                    ),
                                  )) //)
                            ],
                          )))


                ])

            ),
          ),
          Positioned(
              left: 20,
              top: 40,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white54,
                    child: IconButton(
                      onPressed: () {
                        SearchButtonPressed();
                      },
                      icon: const Icon(Icons.search),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenwidth-140),
                    alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white54,
                    child: IconButton(
                      onPressed: () {
                        FilterButtonPressed();
                      },
                      icon: const Icon(Icons.filter_alt_outlined),
                      color: Colors.white,
                    ),
                  ))
                ],
              )),
        ],
      ),
    );
}

void SearchButtonPressed() {
Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
}
void FilterButtonPressed() {
Navigator.push(context, MaterialPageRoute(builder: (context) => FilterPage()));
}
void LikeButtonPressed() {

  }
void DisslikeButtonPressed() {

  }

}

