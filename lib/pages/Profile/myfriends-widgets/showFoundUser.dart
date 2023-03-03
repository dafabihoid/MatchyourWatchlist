import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/DTOs/UserDataDTO.dart';
import 'package:watchlist/Singleton/AppData.dart';

import '../../../DTOs/FriendsDTO.dart';
import '../../../backend/Controller.dart';
import '../../../utils/myThemes.dart';

class showFoundUser extends StatefulWidget {
  final UserDataDTO founduser;
  final Function parentcallbacksetstate;
  final Function synchornize;
  const showFoundUser({Key? key, required this.founduser,required this.parentcallbacksetstate, required this.synchornize}) : assert(founduser != null), super(key: key);



  @override
  State<showFoundUser> createState() => _showFoundUserState();
}
class _showFoundUserState extends State<showFoundUser> {
  AppData appData = AppData();
  _showFoundUserState();



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
        title: Text(widget.founduser.userName),
        subtitle: Text(widget.founduser.userAccountName),
        trailing: Wrap(
          children: [
            IconButton(icon: Icon(Icons.person_add) , onPressed: () {

              sendFriendRequest(appData.userData.userId,widget.founduser.userId);

              FriendsDTO(UserID: appData.userData.userId,
                         FriendID: widget.founduser.userId,
                         Status: "pending",
                         FriendUserName: widget.founduser.userName,
                         FriendUserDisplayName: widget.founduser.userAccountName).UpdateSentRequestList();
              widget.synchornize();
              appData.findUserList.remove(widget.founduser);
              widget.synchornize();
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