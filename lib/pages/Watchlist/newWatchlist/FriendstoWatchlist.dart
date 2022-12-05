import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/Watchlist/newWatchlist/WatchlistFilters.dart';

import '../../../class/Friends.dart';
import '../../../utils/myThemes.dart';
import '../../Profile/myFriends.dart';

class FriendstoWatchlist extends StatefulWidget {
  const FriendstoWatchlist({Key? key}) : super(key: key);

  @override
  State<FriendstoWatchlist> createState() => _FriendstoWatchlistState();
}

class _FriendstoWatchlistState extends State<FriendstoWatchlist> {

  final Friend= [
    Friends(
      username: "TestUsername",
      anzeigename: "TestAnzeigename",
    ),
    Friends(
      username: "TestUsername1",
      anzeigename: "TestAnzeigename1",

    ),
    Friends(
      username: "TestUsername2",
      anzeigename: "TestAnzeigename2",

    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(""),
        //    backgroundColor: Colors.black12,
      ),
        body: Container(
            padding: EdgeInsets.all(16),
            child:Column(
              children: [
                TextField(
                  //controller: SearchController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Freunde finden",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.black)
                      )
                  ),

                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("Freunde",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Spacer()
                  ],
                ),

                Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: Friend.length,
                      itemBuilder: (context, index){
                        return showFriends(friends: Friend[index]);
                      }

                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(Size(170,55),),
                        backgroundColor: MaterialStateProperty.all<Color>(MyThemes.kAccentColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Zurück",
                        style: TextStyle(
                          color: themeProvider.isDarkMode ?Colors.white : Colors.black,
                          fontSize: 20,
                        ),
                      ),

                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(Size(170,55),),
                        backgroundColor: MaterialStateProperty.all<Color>(MyThemes.kAccentColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WatchlistFilters()));
                      },
                      child: Text(
                        "Weiter",
                        style: TextStyle(
                          color: themeProvider.isDarkMode ?Colors.white : Colors.black,
                          fontSize: 20,
                        ),
                      ),

                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 10,)
              ],
            )
        )
    );
  }
}
