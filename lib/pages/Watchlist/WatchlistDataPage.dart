import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/DTOs/ListWithMediaDTO.dart';
import 'package:watchlist/Widgets/MediaList.dart';

import '../../utils/Enum.dart';
import '../../utils/GlobalString.dart';

class WatchlistDataPage extends StatelessWidget {
  ListWithMediaDTO listWithMediaDTO;
  IconType IconType1 = IconType.nichts;
  IconType IconType2 = IconType.nichts;

  WatchlistDataPage({Key? key, required this.listWithMediaDTO}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //  backgroundColor: Colors.black12,
          title: Text(listWithMediaDTO.listName),
        ),
        body: loadMediaListByListType()//MediaView(Icon(Icons.visibility_off),IconType1, Icon(Icons.delete), IconType2 ),
    );
  }

  MediaList loadMediaListByListType(){
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagMainList){
      return MediaList(listWithMediaDTO: listWithMediaDTO, Icon2: Icon(Icons.delete), IconType1: IconType1, IconType2: IconType2, Icon1: Icon(Icons.visibility));
    }
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagAlreadyWatchedList){
      return MediaList(listWithMediaDTO: listWithMediaDTO, Icon2: Icon(Icons.delete), IconType1: IconType1, IconType2: IconType2, Icon1: Icon(Icons.visibility_off));
    }
    return MediaList(listWithMediaDTO: listWithMediaDTO, Icon2: Icon(null), IconType1: IconType1, IconType2: IconType2, Icon1: Icon(null),);
  }
}