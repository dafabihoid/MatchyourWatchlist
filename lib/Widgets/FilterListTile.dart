import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Singleton/ListCreationFilter.dart';
import 'package:watchlist/utils/GlobalString.dart';

class FilterListTile extends StatefulWidget {
  final String tileField;
  final Object tileId;
  final String tileValue;

  final ValueChanged<int> update;

  const FilterListTile({
    Key? key,
    required this.tileField,
    required this.tileId,
    required this.tileValue,
    required this.update,
  }) : super(key: key);

  @override
  State<FilterListTile> createState() => _FilterListTile();
}

class _FilterListTile extends State<FilterListTile> {
  late String tileField;
  late Object tileId;
  late String tileValue;
  Icon checkBox = const Icon(Icons.check_box_outline_blank);
  ListCreationFilter listCreationFilter = ListCreationFilter();

  void switchIcon(){
    switch(tileField){
      case(GlobalStrings.language):
        if (listCreationFilter.getLanguage() == tileId){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.genreOfMovies):
        if (listCreationFilter.genreMovieIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.genreOfSeries):
        if (listCreationFilter.genreSeriesIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.provider):
        if (listCreationFilter.mediaProviderIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.mediaTyp):
        if (listCreationFilter.mediaTypes.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
    }
  }

  void changeFilterSettings(){
    switch(tileField){
      case(GlobalStrings.language):
        if (listCreationFilter.getLanguage() == tileId){
          if(listCreationFilter.getLanguage() == "en"){
            listCreationFilter.setLanguage("de");
          } else {
            listCreationFilter.setLanguage("en");
          }
          widget.update(0);
          return;
        }
        listCreationFilter.setLanguage(tileId as String);
        widget.update(0);
        break;
      case(GlobalStrings.genreOfMovies):
        if (listCreationFilter.genreMovieIds.contains(tileId)){
          listCreationFilter.genreMovieIds.remove(tileId);
          if(listCreationFilter.genreMovieIds.isEmpty){
            if (tileId == 28){
              listCreationFilter.genreMovieIds.add(12);
            } else {
              listCreationFilter.genreMovieIds.add(28);
            }
          }
          widget.update(0);
          return;
        }
        listCreationFilter.genreMovieIds.add(tileId as int);
        break;
      case(GlobalStrings.genreOfSeries):
        if (listCreationFilter.genreSeriesIds.contains(tileId)){
          listCreationFilter.genreSeriesIds.remove(tileId);
          listCreationFilter.genreSeriesIds.remove(tileId);
          if(listCreationFilter.genreSeriesIds.isEmpty){
            if (tileId == 10759){
              listCreationFilter.genreSeriesIds.add(16);
            } else {
              listCreationFilter.genreSeriesIds.add(10759);
            }
          }
          widget.update(0);
          return;
        }
        listCreationFilter.genreSeriesIds.add(tileId as int);
        break;
      case(GlobalStrings.provider):
        if (listCreationFilter.mediaProviderIds.contains(tileId)){
          listCreationFilter.mediaProviderIds.remove(tileId);
          listCreationFilter.mediaProviderIds.remove(tileId);
          if(listCreationFilter.mediaProviderIds.isEmpty){
            if (tileId == 8){
              listCreationFilter.mediaProviderIds.add(9);
            } else {
              listCreationFilter.mediaProviderIds.add(8);
            }
          }
          widget.update(0);
          return;
        }
        listCreationFilter.mediaProviderIds.add(tileId as int);
        break;
      case(GlobalStrings.mediaTyp):
        if (listCreationFilter.mediaTypes.contains(tileId)){
          listCreationFilter.mediaTypes.remove(tileId);
          listCreationFilter.mediaTypes.remove(tileId);
          if(listCreationFilter.mediaTypes.isEmpty){
            if (tileId == "movie"){
              listCreationFilter.mediaTypes.add("tv");
            } else {
              listCreationFilter.mediaTypes.add("movie");
            }
          }
          widget.update(0);
          return;
        }
        listCreationFilter.mediaTypes.add(tileId as String);
        break;
    }
  }

  void onFilterPress(){
    changeFilterSettings();
    switchIcon();
  }

  @override
  Widget build(BuildContext context) {
    tileField = widget.tileField;
    tileId = widget.tileId;
    tileValue = widget.tileValue;
    switchIcon();

    return ListTile(
      title: Text(
        tileValue,
      ),
      trailing: checkBox,
      onTap: () {
        onFilterPress();
        setState(() {
        });
      },
    );
  }

}