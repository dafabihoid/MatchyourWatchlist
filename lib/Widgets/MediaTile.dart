import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/backend/Controller.dart';
import '../DTOs/ListWithMediaDTO.dart';
import '../DTOs/MediaDTO.dart';
import '../class/Genre.dart';
import '../utils/Enum.dart';

class MediaTile extends StatefulWidget {
  MediaDTO media;
  ListWithMediaDTO thisListWithMediaDTO;
  List<MediaDTO> transferMediaList;
  Icon Icon1;
  Icon Icon2;
  IconType IconType1;
  IconType IconType2;
  final Function parentCallbackSetState;

  MediaTile({Key? key, required this.media, required this.thisListWithMediaDTO, required this.transferMediaList, required this.Icon1, required this.IconType1, required this.Icon2, required this.IconType2, required this.parentCallbackSetState}) : super(key: key);

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
                case IconType.remove:
                  break;
              }

            },),
            IconButton(icon: widget.Icon2, onPressed: (){
              switch(widget.IconType2){
                case IconType.bereitsgsehen: {

                }
                break;
                case IconType.add: {
                  manageTransferMediaList();
                  setState(() {
                    widget.Icon2 = Icon(Icons.check);
                    widget.IconType2 = IconType.remove;
                  });
                }
                break;
                case IconType.delete: {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Löschen"),
                        content: Text("Bist du sicher?"),
                        actions: [
                          TextButton(
                            child: Text('Abbrechen',),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text('Ja',),
                            onPressed: () {
                              deleteThisMediaFromWatchlist();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                break;
                case IconType.nochnichtgesehen: {

                }
                break;
                case IconType.nichts: {

                }
                break;
                case IconType.remove: {
                  manageTransferMediaList();
                  setState(() {
                    widget.Icon2 = Icon(Icons.add);
                    widget.IconType2 = IconType.add;
                  });
                }
                break;
              }
            },)

          ],
        ),
      ),
    );
  }
  void deleteThisMediaFromWatchlist(){
    widget.thisListWithMediaDTO.mediaDTOList.remove(widget.media);
    deleteMediaFromWatchlist(widget.thisListWithMediaDTO.listId, widget.media);
    widget.parentCallbackSetState();
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
        str = element.genreName;
      } else {
        str = "$str, ${element.genreName}";
      }
    }
    return str;
  }
}
