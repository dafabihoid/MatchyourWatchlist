import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Singleton/ListCreationFilter.dart';
import 'package:watchlist/Singleton/ListCreationFilter.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/pages/main.dart';
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
        if (listCreationFilter.filterSettingData.genreMovieIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.genreOfSeries):
        if (listCreationFilter.filterSettingData.genreSeriesIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.provider):
        if (listCreationFilter.filterSettingData.mediaProviderIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.mediaTyp):
        if (listCreationFilter.filterSettingData.mediaTypes.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
    }
  }

  void changeFilterSettings(){
    listCreationFilter.filterSettingsChanged = true;
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
        if (listCreationFilter.filterSettingData.genreMovieIds.contains(tileId)){
          listCreationFilter.filterSettingData.genreMovieIds.remove(tileId);
          if(listCreationFilter.filterSettingData.genreMovieIds.isEmpty){
            if (tileId == 28){
              listCreationFilter.filterSettingData.genreMovieIds.add(12);
            } else {
              listCreationFilter.filterSettingData.genreMovieIds.add(28);
            }
          }
          widget.update(0);
          return;
        }
        listCreationFilter.filterSettingData.genreMovieIds.add(tileId as int);
        break;
      case(GlobalStrings.genreOfSeries):
        if (listCreationFilter.filterSettingData.genreSeriesIds.contains(tileId)){
          listCreationFilter.filterSettingData.genreSeriesIds.remove(tileId);
          if(listCreationFilter.filterSettingData.genreSeriesIds.isEmpty){
            if (tileId == 10759){
              listCreationFilter.filterSettingData.genreSeriesIds.add(16);
            } else {
              listCreationFilter.filterSettingData.genreSeriesIds.add(10759);
            }
          }
          widget.update(0);
          return;
        }
        listCreationFilter.filterSettingData.genreSeriesIds.add(tileId as int);
        break;
      case(GlobalStrings.provider):
        if (listCreationFilter.filterSettingData.mediaProviderIds.contains(tileId)){
          listCreationFilter.filterSettingData.mediaProviderIds.remove(tileId);
          if(listCreationFilter.filterSettingData.mediaProviderIds.isEmpty){
            if (tileId == 8){
              listCreationFilter.filterSettingData.mediaProviderIds.add(9);
            } else {
              listCreationFilter.filterSettingData.mediaProviderIds.add(8);
            }
          }
          widget.update(0);
          return;
        }
        listCreationFilter.filterSettingData.mediaProviderIds.add(tileId as int);
        break;
      case(GlobalStrings.mediaTyp):
        if (listCreationFilter.filterSettingData.mediaTypes.contains(tileId)){
          listCreationFilter.filterSettingData.mediaTypes.remove(tileId);
          if(listCreationFilter.filterSettingData.mediaTypes.isEmpty){
            if (tileId == "movie"){
              listCreationFilter.filterSettingData.mediaTypes.add("tv");
            } else {
              listCreationFilter.filterSettingData.mediaTypes.add("movie");
            }
          }
          widget.update(0);
          return;
        }
        listCreationFilter.filterSettingData.mediaTypes.add(tileId as String);
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