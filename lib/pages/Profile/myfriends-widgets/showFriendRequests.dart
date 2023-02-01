import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../DTOs/FriendsDTO.dart';
import '../../../backend/Controller.dart';
import '../../../utils/myThemes.dart';

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