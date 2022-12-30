import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/DTOs/ListWithMediaDTO.dart';
import 'package:watchlist/utils/MediaTile.dart';

import '../class/Media.dart';
import 'Enum.dart';

class MediaList extends StatefulWidget {
  ListWithMediaDTO listWithMediaDTO;
  Icon Icon1;
  Icon Icon2;
  IconType IconType1;
  IconType IconType2;

   MediaList( {Key? key,required this.listWithMediaDTO, required this.Icon2, required this.IconType1, required this.IconType2, required this.Icon1,}) : super(key: key);

  @override
  State<MediaList> createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
          child: ListView.builder(
              itemCount: widget.listWithMediaDTO.mediaDTOList.length,
              itemBuilder: (context, index){
                return MediaTile(media: widget.listWithMediaDTO.mediaDTOList[index], Icon1: widget.Icon1, Icon2: widget.Icon2, IconType1: widget.IconType1, IconType2: widget.IconType2, );
              }

          ),
        ),
      ),
    );
  }
}
