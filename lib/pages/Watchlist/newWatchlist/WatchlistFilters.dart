import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Widgets/FilterList.dart';
import 'package:watchlist/pages/mainPage.dart';

import '../../../Singleton/NewWatchlistProvider.dart';
import '../../../utils/myThemes.dart';
import '../WatchlistPage.dart';

class WatchlistFilters extends StatefulWidget {
  const WatchlistFilters({Key? key}) : super(key: key);

  @override
  State<WatchlistFilters> createState() => _WatchlistFiltersState();
}

class _WatchlistFiltersState extends State<WatchlistFilters> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    WatchlistSingleton watchlistSingleton = new WatchlistSingleton();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(""),
        //    backgroundColor: Colors.black12,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(15),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(child: Container(height:500,
                    child: SingleChildScrollView(child:
                       FilterList()),
                  ),


                  ),
                  Positioned(bottom: 1,
                    child: Row(
                      children: [

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
                          onPressed: () {
                            for (var age in watchlistSingleton.addedFriends) {
                              print(age.username);
                            }
                            watchlistSingleton.addedFriends.clear();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                          },
                          child: Text(
                            "Erstellen",
                            style: TextStyle(
                              color: themeProvider.isDarkMode ?Colors.white : Colors.black,
                              fontSize: 20,
                            ),
                          ),

                        ),
                      ],
                    ),
                  )

                ],

              )





      ),
    );
  }


}
