import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/DTOs/ListDTO.dart';
import 'package:watchlist/utils/MediaList.dart';

import '../../utils/Enum.dart';

class WatchlistWithFriendsPage extends StatelessWidget {
   WatchlistWithFriendsPage({Key? key, required this.listDTO}) : super(key: key);
  ListDTO listDTO;
  IconType IconType1 = IconType.nichts;
  IconType IconType2 = IconType.nichts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //  backgroundColor: Colors.black12,
          title: Text(listDTO.WatchlistName),
        ),
        body: MediaList(Icon2: Icon(null), IconType1: IconType1, IconType2: IconType2, Icon1: Icon(null),)//MediaView(Icon(Icons.visibility_off),IconType1, Icon(Icons.delete), IconType2 ),
    );
  }
}
