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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/assets/test.jpg"),
                        fit: BoxFit.cover)),
              )),
          Positioned(
              top: 400,
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 25),
                width: screenwidth,
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )
                ),

                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                    child: Text("Doktor Strange: Madness of Multiverse",
                      style: TextStyle(
                        fontSize: 25,

                      ),)),

                    Container(
                      alignment: Alignment.centerLeft,
                    child: Text("Fantasie, Sci Fi",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45
                      ),)),
                    Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                      CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: IconButton(
                        onPressed: () {},
                        color: Colors.black,
                        icon: Icon(Icons.cancel),
                      ),),

                        Container(
                          margin: EdgeInsets.only(left: screenwidth-180),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            onPressed: () {},
                            color: Colors.black,
                            icon: Icon(Icons.favorite_outlined),
                          ),))



                      ],
                    )
                    )
                  ],
                ),


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
                      onPressed: () {},
                      icon: Icon(Icons.filter_alt_outlined),
                      color: Colors.white,
                    ),
                  )


                ],
              )),

        ],
      ),
    );
  }
}
