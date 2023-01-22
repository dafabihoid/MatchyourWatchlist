import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/DTOs/FriendsDTO.dart';
import 'package:watchlist/Singleton/AppData.dart';
import 'package:watchlist/class/Friends.dart';
import 'package:watchlist/utils/ButtonsProvider.dart';
import 'package:watchlist/utils/myThemes.dart';

import '../../Singleton/NewWatchlistProvider.dart';
import '../../backend/Controller.dart';

class myFriends extends StatefulWidget {
  const myFriends({Key? key}) : super(key: key);

  @override
  State<myFriends> createState() => _myFriendsState();
}

class _myFriendsState extends State<myFriends> {
  AppData appData = AppData();

  void callBackSetState(){
    setState(() {

    });
  }




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
              Text("Ausstehende Anfragen",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Spacer()
            ],
          ),

          Container(
            height: 300,
            child: ListView.builder(
                itemCount: appData.Friendrequests.length,
                itemBuilder: (context, index){
                  return showFriendRequests(friends: appData.Friendrequests.elementAt(index),parentcallbacksetstate: callBackSetState,);
                }

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
                itemCount: appData.Friends.length,
                itemBuilder: (context, index){
                  return showFriends(friends: appData.Friends.elementAt(index), parentcallbacksetstate: callBackSetState,);
                }

            ),
          ),

        ],
      )
      )
    );
  }
}

class showFriendRequests extends StatefulWidget {
  final FriendsDTO friends;
  final Function parentcallbacksetstate;
  const showFriendRequests({Key? key, required this.friends,required this.parentcallbacksetstate}) : assert(friends != null), super(key: key);

  @override
  State<showFriendRequests> createState() => _showFriendRequestsState();
}
class _showFriendRequestsState extends State<showFriendRequests> {
  _showFriendRequestsState();

  bool clicked = false;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);


    return InkWell(
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
        trailing: Wrap(
          children: [
            IconButton(icon: Icon(Icons.add) , onPressed: () {
              acceptFriendRequest(widget.friends.UserID,widget.friends.FriendID);
              widget.friends.UpdateRequestList_add();
              widget.parentcallbacksetstate();
              setState(() {

              });

            },),
            IconButton(icon: Icon(Icons.remove), onPressed: () {
              denyFriendRequest(widget.friends.UserID,widget.friends.FriendID);
              widget.friends.UpdateRequestList_deny();
              widget.parentcallbacksetstate();
              setState(() {

              });
            },),
          ],
        ),
      ),
    );
  }
}

class showFriends extends StatefulWidget {
  final FriendsDTO friends;
  final Function parentcallbacksetstate;
  const showFriends({Key? key, required this.friends, required this.parentcallbacksetstate}) : assert(friends != null), super(key: key);

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
                  onPressed: () {
                    deleteFriendship(widget.friends.UserID,widget.friends.FriendID);
                    widget.friends.UpdateFriendList();
                    widget.parentcallbacksetstate();
                    setState(() {

                    });

                  }, child: Text("Freund entfernen"),)),
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
