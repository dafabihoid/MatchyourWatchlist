import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../utils/Enum.dart';
import '../../utils/MediaList.dart';



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
      body: MediaList(Icon2: Icon(Icons.delete), IconType1: IconType1, IconType2: IconType2, Icon1: Icon(Icons.visibility_off))//MediaView(Icon(Icons.visibility_off),IconType1, Icon(Icons.delete), IconType2 ),
    );
  }


}
