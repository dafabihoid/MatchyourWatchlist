import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DTOs/MediaDTO.dart';
import '../class/Genre.dart';
import '../utils/Enum.dart';

class MediaTile extends StatefulWidget {
  MediaDTO media;
  List<MediaDTO> transferMediaList;
  Icon Icon1;
  Icon Icon2;
  IconType IconType1;
  IconType IconType2;

  MediaTile({Key? key, required this.media, required this.transferMediaList, required this.Icon1, required this.IconType1, required this.Icon2, required this.IconType2}) : super(key: key);

  @override
  State<MediaTile> createState() => _MediaTileState();
}

class _MediaTileState extends State<MediaTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.media.posterPath),
      title: Text(widget.media.title),
      subtitle: Text(getGenresAsString(widget.media.genres)),
      trailing: SizedBox( width: 100,
        child:
          widget.IconType1 == IconType.nichts && widget.IconType2 == IconType.nichts ? const SizedBox() :
          Row(
          children: [

            IconButton(icon: widget.Icon1, onPressed: () {

              switch(widget.IconType1){
                case IconType.bereitsgsehen: {
                  manageTransferMediaList();
                  setState(() {
                    widget.Icon1 = Icon(Icons.visibility_off);
                    widget.IconType1 = IconType.nochnichtgesehen;
                  });
                }
                break;
                case IconType.add: {

                }
                break;
                case IconType.delete: {

                }
                break;
                case IconType.nochnichtgesehen: {
                  manageTransferMediaList();
                  setState(() {
                    widget.Icon1 = Icon(Icons.visibility);
                    widget.IconType1 = IconType.bereitsgsehen;
                  });
                }
                break;
                case IconType.nichts: {

                }
                break;
              }

            },),
            IconButton(icon: widget.Icon2, onPressed: (){
              switch(widget.IconType2){
                case IconType.bereitsgsehen: {

                }
                break;
                case IconType.add: {

                }
                break;
                case IconType.delete: {

                }
                break;
                case IconType.nochnichtgesehen: {

                }
                break;
                case IconType.nichts: {

                }
                break;
              }
            },)

          ],
        ),
      ),
    );
  }

  void manageTransferMediaList(){
    //widget.transferMediaList.contains(widget.media) ? widget.transferMediaList.remove(widget.media) : widget.transferMediaList.add(widget.media);
    if(widget.transferMediaList.contains(widget.media)){
      widget.transferMediaList.remove(widget.media);
    } else {
      widget.transferMediaList.add(widget.media);
    }
  }

  String getGenresAsString(List<dynamic> genres){
    String str = "";
    for (Genre element in genres) {
      if (str == ""){
        str = "${element.genreId}";
      } else {
        str = "$str, ${element.genreId}";
      }
    }
    return str;
  }
}
