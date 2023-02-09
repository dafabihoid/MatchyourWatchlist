import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/backend/Controller.dart';
import 'package:watchlist/pages/Watchlist/WatchlistTile.dart';
import 'package:watchlist/pages/Watchlist/newWatchlist/FriendstoWatchlist.dart';
import 'package:watchlist/utils/GlobalString.dart';
import '../../utils/myThemes.dart';


class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  BackendDataProvider backendDataProvider = BackendDataProvider();
  bool needReload = false;

  FutureOr setStateCallback(){
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    if(needReload = true){
      needReload = false;
      setState(() {});
    }
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
                         Navigator.push(context, MaterialPageRoute(builder: (context) => FriendstoWatchlist(setStateCallbackToParent: setStateCallback,)));
                       },
                       icon: const Icon(Icons.add),
                       color: themeProvider.isDarkMode ? Colors.white : Colors.black
                     ),
                   ),
                 ],
               ),
              //SizedBox(height: 15),
              //EigeneWatchlistWidget(),
              //const SizedBox(height: 10),
              //BereitsGesehenWidget(),

              SizedBox(
                height: backendDataProvider.listWithMediaDTOList.length * 200 + 20,
                width: 400,
                child: FutureBuilder(
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (backendDataProvider.listWithMediaDTOList.isEmpty) {
                    return Container(
                      child: Center(
                        child: Text("Loading"),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: backendDataProvider.listWithMediaDTOList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onLongPress: () {
                              if(backendDataProvider.listWithMediaDTOList[index].listType == GlobalStrings.listTypeFlagMainList || backendDataProvider.listWithMediaDTOList[index].listType == GlobalStrings.listTypeFlagAlreadyWatchedList) {
                                return;
                              }
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Watchlist löschen"),
                                    content: Text("Bist du sicher?"),
                                    actions: [
                                      TextButton(
                                        child: Text('Abbrechen',),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Ja',),
                                        onPressed: () {
                                          deleteWatchlistForUser(backendDataProvider.listWithMediaDTOList[index].listId);
                                          backendDataProvider.listWithMediaDTOList.remove(backendDataProvider.listWithMediaDTOList[index]);
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child:  WatchlistTile(
                                listWithMediaDTO: backendDataProvider.listWithMediaDTOList[index]),
                          );
                        });
                  }
                }),
              ),




            ]))));
  }
}
