import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/Watchlist/BereitsGesehenPage.dart';
import 'package:watchlist/pages/Watchlist/WatchlistWithFriends.dart';
import 'package:watchlist/pages/Watchlist/newWatchlist/FriendstoWatchlist.dart';
import '../../DTOs/ListDTO.dart';
import '../../class/Media.dart';
import '../../utils/myThemes.dart';
import 'BereitsGesehenWidget.dart';
import 'EigeneWatchlistPage.dart';
import 'EigeneWatchlistWidget.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(25),
            child: SingleChildScrollView(
                child: Column(
                    children: [
              const SizedBox(height: 15),
               Row(
                 children: [
                   CircleAvatar(
                     radius: 25,
                     backgroundColor: Colors.transparent,
                     child: IconButton(
                       enableFeedback: false,
                         highlightColor: Colors.transparent,
                         splashColor: Colors.transparent,
                       onPressed: () {
                       },
                       icon: Icon(null),
                       color: Colors.black,

                     ),
                   ),
                   Spacer(),
                   Center(
                    child: Text(
                      "Watchlists",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
              ),
                   Spacer(),
                   CircleAvatar(
                     radius: 25,
                     backgroundColor: MyThemes.kAccentColor,
                     child: IconButton(
                       onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => FriendstoWatchlist()));
                       },
                       icon: const Icon(Icons.add),
                       color: themeProvider.isDarkMode ? Colors.white : Colors.black
                     ),
                   ),
                 ],
               ),
              SizedBox(height: 15),
              EigeneWatchlistWidget(),
              const SizedBox(height: 10),
              BereitsGesehenWidget(),

              SizedBox(
                height: ErikApi.ErikApiListe.length * 113 + 20,
                width: 400,
                child: FutureBuilder(
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (ErikApi.ErikApiListe == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading"),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: ErikApi.ErikApiListe.length,
                        itemBuilder: (BuildContext context, int index) {
                          return WatchlistWithFriends(
                              listTDO: ErikApi.ErikApiListe[index]);
                        });
                  }
                }),
              ),




            ]))));
  }
}
