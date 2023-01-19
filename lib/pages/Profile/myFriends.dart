import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/class/Friends.dart';
import 'package:watchlist/utils/myThemes.dart';

import '../../Singleton/NewWatchlistProvider.dart';

class myFriends extends StatefulWidget {
  const myFriends({Key? key}) : super(key: key);

  @override
  State<myFriends> createState() => _myFriendsState();
}

class _myFriendsState extends State<myFriends> {

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
        title: const Text("Meine Freunde"),
      //  backgroundColor: Colors.black12,
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

        ],
      )
      )
    );
  }
}

class showFriends extends StatefulWidget {
  final Friends friends;
  const showFriends({Key? key, required this.friends}) : assert(friends != null), super(key: key);

  @override
  State<showFriends> createState() => _showFriendsState();
}
class _showFriendsState extends State<showFriends> {
  _showFriendsState();
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
        title: Text(widget.friends.anzeigename),
        subtitle: Text(widget.friends.username),
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
            element.username == widget.friends.username);
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
                      child: Text(widget.friends.anzeigename),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.friends.username),
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