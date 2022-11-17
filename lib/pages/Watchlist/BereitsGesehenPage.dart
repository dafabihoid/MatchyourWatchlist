import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Widgets/MediaView.dart';

import '../../utils/Enum.dart';



class BereitsGesehen extends StatelessWidget {
   BereitsGesehen({Key? key}) : super(key: key);

  IconType IconType1 = IconType.nochnichtgesehen;
  IconType IconType2 = IconType.delete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //  backgroundColor: Colors.black12,
        title: const Text("Bereits gesehen"),
      ),
      body: MediaView(Icon(Icons.visibility_off),IconType1, Icon(Icons.delete), IconType2 ),
    );
  }
}
