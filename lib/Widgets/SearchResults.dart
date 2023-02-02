
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DTOs/ListWithMediaDTO.dart';
import '../utils/Enum.dart';
import 'MediaList.dart';

class SearchResults extends StatelessWidget {
  ListWithMediaDTO listWithMediaDTO;
  ListWithMediaDTO listWithMediaDTOWhichWillBeAdded;
  IconType IconType1 = IconType.nichts;
  IconType IconType2 = IconType.nichts;

  SearchResults({Key? key, required this.listWithMediaDTO, required this.listWithMediaDTOWhichWillBeAdded}) : super(key: key) {}


  @override
  Widget build(BuildContext context) {
    return Container(
      child: MediaList(listWithMediaDTO: listWithMediaDTO, transferList: listWithMediaDTOWhichWillBeAdded, Icon1: Icon(null), IconType1: IconType.nichts, Icon2: Icon(Icons.playlist_add), IconType2: IconType.add)
    );
  }

}