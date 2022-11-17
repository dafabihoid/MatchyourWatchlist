import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Widgets/MediaView.dart';

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
      body: MediaView(Icon(Icons.visibility),IconType1, Icon(Icons.delete), IconType2 )
    );
  }
}
