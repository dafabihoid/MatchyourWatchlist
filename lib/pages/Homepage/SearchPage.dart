import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/DTOs/ListWithMediaDTO.dart';
import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/Widgets/SearchResults.dart';

import '../../DTOs/MediaDTO.dart';
import '../../backend/Controller.dart';
import '../../utils/GlobalString.dart';
import '../../utils/SearchStatus.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ListWithMediaDTO searchResults = ListWithMediaDTO(listId: -1, listName: "noName", listType: "noType", mediaDTOList: []);
  ListWithMediaDTO addedMedia = ListWithMediaDTO(listId: -1, listName: "noName", listType: "noType", mediaDTOList: []);
  SearchStatus searchStatus = SearchStatus.notSearching;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
        //  backgroundColor: Colors.black12,
          title: const Text("Suchen"),
        ),

        body: Column(
          children: [
              Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: textEditingController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      searchForMovie(textEditingController.text);
                    },
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            searchForMovie(textEditingController.text);
                          },
                        ),
                        hintText: "Film Title",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.black)
                        )
                    ),
                  )
              ),
              const SizedBox(
                height: 0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: getWidgetBySearchStatus(context),
              ),
          ],
        )
      ),
      onWillPop: () async {
        addedMedia.mediaDTOList.isEmpty ? null : addSelectedMediaToWatchlist();
        return true;
      },
    );
  }

  void addSelectedMediaToWatchlist(){
    BackendDataProvider backendDataProvider = BackendDataProvider();
    for (var element in addedMedia.mediaDTOList) {
      addMediaToWatchlist(element);
      backendDataProvider.addMediaToListWithMediaByListType(GlobalStrings.listTypeFlagMainList, element);
    }
  }

  void searchForMovie(String searchText){
    if(searchStatus == SearchStatus.searching){
      return;
    }
    print("Searching");
    searchStatus = SearchStatus.searching;
    setState(() {});
    Future<List<MediaDTO>> futureMovieDTO = searchForMediaByTextAndReturnMediaDTOList(searchText);
    futureMovieDTO.then((result) {
      if(result == List.empty()){
        searchStatus = SearchStatus.nothingFound;
      } else {
        searchResults.mediaDTOList = result;
        searchStatus = SearchStatus.mediaFound;
      }
      setState(() {});
    });
  }

  Widget getWidgetBySearchStatus(BuildContext context){
    switch(searchStatus){
      case SearchStatus.mediaFound:
        return SearchResults(listWithMediaDTO: searchResults, listWithMediaDTOWhichWillBeAdded: addedMedia);
      case SearchStatus.searching:
        return const CircularProgressIndicator();
      case SearchStatus.notSearching:
        return const SizedBox();
      case SearchStatus.nothingFound:
        return const SizedBox(
          child: Text("Nichts gefunden"),
        );
    }
  }
}
