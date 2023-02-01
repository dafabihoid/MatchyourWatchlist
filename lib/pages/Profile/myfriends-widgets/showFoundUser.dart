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
  const showFoundUser({Key? key, required this.founduser,required this.parentcallbacksetstate}) : assert(founduser != null), super(key: key);



  @override
  State<showFoundUser> createState() => _showFoundUserState();
}
class _showFoundUserState extends State<showFoundUser> {
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
        title: Text(widget.founduser.userAccountName),
        subtitle: Text(widget.founduser.userName),
        trailing: Wrap(
          children: [
            IconButton(icon: Icon(Icons.add) , onPressed: () {
              /*sendFriendRequest(widget.founduser.,widget.founduser.FriendID);
              widget.founduser.UpdateRequestList_add();
              widget.parentcallbacksetstate();

              */
              setState(() {

              });

            },),
            IconButton(icon: Icon(Icons.remove), onPressed: () {
              /*
              denyFriendRequest(widget.founduser.UserID,widget.founduser.FriendID);
              widget.founduser.UpdateRequestList_deny();
              widget.parentcallbacksetstate();

               */
              setState(() {

              });
            },),
          ],
        ),
      ),
    );
  }
}