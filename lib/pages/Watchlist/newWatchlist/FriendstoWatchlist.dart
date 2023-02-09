import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/DTOs/FriendsDTO.dart';
import 'package:watchlist/pages/Watchlist/newWatchlist/WatchlistFilters.dart';
import 'package:watchlist/Singleton/WatchlistSingleton.dart';

import '../../../Singleton/AppData.dart';
import '../../../backend/Controller.dart';
import '../../../class/Friends.dart';
import '../../../utils/myThemes.dart';
import '../../Profile/myFriends.dart';
import '../../mainPage.dart';

class FriendstoWatchlist extends StatefulWidget {
  Function setStateCallbackToParent;
  FriendstoWatchlist({Key? key, required this.setStateCallbackToParent}) : super(key: key);

  @override
  State<FriendstoWatchlist> createState() => _FriendstoWatchlistState();
}

class _FriendstoWatchlistState extends State<FriendstoWatchlist> {
  AppData appData = AppData();

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
                      itemCount:  appData.friendsList.length,
                      itemBuilder: (context, index){
                        return showFriendsFabi(friends: appData.friendsList[index]);
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
                      onPressed: () {
                        Future<void> futureCreateNewWatchlists = createNewWatchlistForUser();
                        futureCreateNewWatchlists.then((value) => {
                          widget.setStateCallbackToParent(),
                          Navigator.pop(context)
                        });
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => WatchlistFilters()));
                      },
                      child: Text(
                        "Erstellen",
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

class showFriendsFabi extends StatefulWidget {
  final FriendsDTO friends;
  const showFriendsFabi({Key? key, required this.friends}) : assert(friends != null), super(key: key);

  @override
  _showFriendsFabiState createState() => _showFriendsFabiState();
}
class _showFriendsFabiState extends State<showFriendsFabi> {

  bool clicked = false;
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    WatchlistSingleton watchlistSingleton = new WatchlistSingleton();


    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30)
                )
            ),
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.32,

                builder: (context, scrollController) =>
                    ModalBottomSheet_Friends(context),

              );
            }
        );
      },
      child: ListTile(
        leading: Container(
            child: themeProvider.isDarkMode ? Image.asset(
                "lib/assets/maxl250weiss.png", width: MediaQuery
                .of(context)
                .size
                .width * 0.1) : Image.asset("lib/assets/maxl250.png",
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.1)
        ),
        title: Text(widget.friends.FriendUserDisplayName),
        subtitle: Text(widget.friends.FriendUserName),
        trailing: IconButton(icon: (clicked==false) ? Icon(Icons.add) : Icon(Icons.delete), onPressed: () {
          if (isAdded == false) {
            watchlistSingleton.addedFriends.add(widget.friends);
            isAdded = true;
            clicked = true;
            setState(() {

            });
          }
          else if (isAdded == true) {
            watchlistSingleton.addedFriends.removeWhere((element) =>
            element.FriendUserName == widget.friends.FriendUserName);
            isAdded = false;
            setState(() {
              clicked = false;
            });
          }
        },),
      ),
    );
  }

  Widget ModalBottomSheet_Friends(context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Spacer(),
                themeProvider.isDarkMode ? Image.asset(
                    "lib/assets/maxl250weiss.png", width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.1) : Image.asset("lib/assets/maxl250.png",
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1),
                SizedBox(width: 5,),
                Column(
                  children: [
                    Container(
                      child: Text(widget.friends.FriendUserDisplayName),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.friends.FriendUserName),
                    )
                  ],
                ),
                Spacer()
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
                child: ElevatedButton(
                  onPressed: () {}, child: Text("Freund entfernen"),)),
            SizedBox(width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
                child: ElevatedButton(
                  onPressed: () {}, child: Text("Freund blockieren"),)),
            SizedBox(width: MediaQuery
                .of(context)
                .size
                .width * 0.9, child: ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Abbrechen"),)),
          ],
        )
    );
  }
}
