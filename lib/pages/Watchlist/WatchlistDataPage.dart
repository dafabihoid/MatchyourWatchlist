import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/DTOs/ListWithMediaDTO.dart';
import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/Widgets/MediaList.dart';

import '../../Singleton/AppData.dart';
import '../../backend/Controller.dart';
import '../../utils/Enum.dart';
import '../../utils/GlobalString.dart';

class WatchlistDataPage extends StatelessWidget {
  ListWithMediaDTO listWithMediaDTO;
  late ListWithMediaDTO transferList;
  IconType IconType1 = IconType.nichts;
  IconType IconType2 = IconType.nichts;

  WatchlistDataPage({Key? key, required this.listWithMediaDTO}) : super(key: key) {
    transferList = setTransferListData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            //  backgroundColor: Colors.black12,
            title: Text(listWithMediaDTO.listName),
          ),
          body: loadMediaListByListType()//MediaView(Icon(Icons.visibility_off),IconType1, Icon(Icons.delete), IconType2 ),
      ),
      onWillPop: () async {
        transferList.mediaDTOList.isEmpty ? null : transferMediaBetweenWatchlists();
        return true;
      },
    );
  }

  ListWithMediaDTO setTransferListData(){
    AppData appData = AppData();
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagMainList){
      return ListWithMediaDTO(listId: appData.alreadyWatchedListId, listName: "${appData.mainListId}", listType: GlobalStrings.listTypeFlagTransferList, mediaDTOList: []);
    }
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagAlreadyWatchedList){
      return ListWithMediaDTO(listId: appData.mainListId, listName: "${appData.alreadyWatchedListId}", listType: GlobalStrings.listTypeFlagTransferList, mediaDTOList: []);
    }
    return ListWithMediaDTO(listId: -1, listName: "-1", listType: "noUse", mediaDTOList: []);
  }

  MediaList loadMediaListByListType(){
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagMainList){
      return MediaList(listWithMediaDTO: listWithMediaDTO, transferList: transferList, Icon1: Icon(Icons.visibility), IconType1: IconType.bereitsgsehen, Icon2: Icon(Icons.delete), IconType2: IconType.delete);
    }
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagAlreadyWatchedList){
      return MediaList(listWithMediaDTO: listWithMediaDTO, transferList: transferList, Icon1: Icon(Icons.visibility_off), IconType1: IconType.nochnichtgesehen, Icon2: Icon(Icons.delete), IconType2: IconType.delete);
    }
    return MediaList(listWithMediaDTO: listWithMediaDTO, transferList: transferList, Icon1: Icon(null), IconType1: IconType1, Icon2: Icon(null), IconType2: IconType2);
  }
  
  void transferMediaBetweenWatchlists() {
    transferMediaBetweenWatchLists(transferList);

    BackendDataProvider backendDataProvider = BackendDataProvider();
    for (int i = 0; i < backendDataProvider.listWithMediaDTOList.length; i++) {
      if(backendDataProvider.listWithMediaDTOList[i].listId == transferList.listId){
        backendDataProvider.listWithMediaDTOList[i].mediaDTOList.addAll(transferList.mediaDTOList);
      }
      if(backendDataProvider.listWithMediaDTOList[i].listId == int.parse(transferList.listName)){
        for(var element in transferList.mediaDTOList){
          backendDataProvider.listWithMediaDTOList[i].mediaDTOList.remove(element);
        }
      }
    }
  }
}