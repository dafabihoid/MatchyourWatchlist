import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class myFriends extends StatefulWidget {
  const myFriends({Key? key}) : super(key: key);

  @override
  State<myFriends> createState() => _myFriendsState();
}

class _myFriendsState extends State<myFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Meine Freunde"),
      //  backgroundColor: Colors.black12,
      ),
      body: Center(
          child: Text("myFriends")
      ),
    );
  }
}
