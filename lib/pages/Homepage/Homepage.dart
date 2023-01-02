import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/AppData.dart';
import 'package:watchlist/utils/CardProvider.dart';
import 'package:watchlist/pages/Profile/Profilpage.dart';
import 'package:watchlist/pages/Watchlist/WatchlistPage.dart';


import '../../class/Media.dart';
import '../../Widgets/tinder_Card.dart';
import '../../utils/ButtonsProvider.dart';
import 'FilterPage.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {

  List pages = [
    const ListPage(),
    const ProfilPage(),
  ];

  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
AppData appdata = AppData();
    if (appdata.homePageLoading){
      WidgetsBinding.instance.addPostFrameCallback((_) { loadImageData(); });
      appdata.homePageLoading = false;
    }

  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    final buttonProvider = Provider.of<ButtonsProvider>(context, listen: false);
    final testprovider = Provider.of<CardProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
           Container(
            /*    decoration: BoxDecoration(
             gradient: LinearGradient(
                colors: [
                  Color(0xFF701ebd),
                  Color(0xFF873bcc),
                  Color(0xFFfe4a97),
                  Color(0xFFe17763),
                  Color(0xFF68998c),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft
              )
            ),*/
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Expanded(
                    child: isLoading
                        ?Center(child: CircularProgressIndicator(),)
                        :buildCards(),
                  ),
                  buttonProvider.ButtonsActivated
                      ? buildButtons()
                      : SizedBox()
                ],
              )
           ),
          Positioned(
              left: 30,
              top: 35,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white60,
                    child: IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        SearchButtonPressed();
                      },
                      icon: const Icon(Icons.search),
                      color: Colors.black,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: screenwidth-160),
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white60,
                        child: IconButton(
                          onPressed: () {
                            FilterButtonPressed();
                          },
                          icon: const Icon(Icons.filter_alt_outlined),
                          color: Colors.black,
                        ),
                      ))
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

    return Stack(
      children: provider.getMovies
          .map((movie) => TinderCard(
          movie: movie,
          isFront: provider.getMovies.last == movie,
      ))
      .toList(growable: true),

    );
  }
  Future loadImageData() async {

    setState(() => isLoading = true);
    final provider = Provider.of<CardProvider>(context, listen: false);

    provider.initializeData();
    while(provider.movies.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 200),(){});
    }

    await precacheImage(CachedNetworkImageProvider(provider.movies.last.cover.toString()), context);

    setState(() => isLoading = false);

  }
}

