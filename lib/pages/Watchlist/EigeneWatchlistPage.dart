import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:watchlist/utils/MediaList.dart';

import '../../utils/Enum.dart';



class EigeneWatchlist extends StatelessWidget {
   EigeneWatchlist({Key? key}) : super(key: key);

  IconType IconType1 = IconType.bereitsgsehen;
  IconType IconType2 = IconType.delete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //  backgroundColor: Colors.black12,
        title: const Text("Eigene Watchlist"),
      ),
      body: MediaList(Icon2: Icon(Icons.delete), IconType1: IconType1, IconType2: IconType2, Icon1: Icon(Icons.visibility))
    );
  }
}
