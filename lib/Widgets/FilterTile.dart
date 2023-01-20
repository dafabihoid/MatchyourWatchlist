import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/pages/main.dart';
import 'package:watchlist/utils/GlobalString.dart';

class FilterTile extends StatefulWidget {
  final String tileField;
  final Object tileId;
  final String tileValue;

  final ValueChanged<int> update;

  const FilterTile({
    Key? key,
    required this.tileField,
    required this.tileId,
    required this.tileValue,
    required this.update,
  }) : super(key: key);

  @override
  State<FilterTile> createState() => _FilterTile();
}

class _FilterTile extends State<FilterTile> {
  late String tileField;
  late Object tileId;
  late String tileValue;
  Icon checkBox = const Icon(Icons.check_box_outline_blank);
  MainFilter mainFilter = MainFilter();

  void switchIcon(){
    switch(tileField){
      case(GlobalStrings.language):
        if (mainFilter.getLanguage() == tileId){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.genreOfMovies):
        if (mainFilter.filterSettingData.genreMovieIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.genreOfSeries):
        if (mainFilter.filterSettingData.genreSeriesIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.provider):
        if (mainFilter.filterSettingData.mediaProviderIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.mediaTyp):
        if (mainFilter.filterSettingData.mediaTypes.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
    }
  }

  void changeFilterSettings(){
    mainFilter.filterSettingsChanged = true;
    switch(tileField){
      case(GlobalStrings.language):
        if (mainFilter.getLanguage() == tileId){
          if(mainFilter.getLanguage() == "en"){
            mainFilter.setLanguage("de");
          } else {
            mainFilter.setLanguage("en");
          }
          widget.update(0);
          return;
        }
        mainFilter.setLanguage(tileId as String);
        widget.update(0);
        break;
      case(GlobalStrings.genreOfMovies):
        if (mainFilter.filterSettingData.genreMovieIds.contains(tileId)){
          mainFilter.filterSettingData.genreMovieIds.remove(tileId);
          if(mainFilter.filterSettingData.genreMovieIds.isEmpty){
            if (tileId == 28){
              mainFilter.filterSettingData.genreMovieIds.add(12);
            } else {
              mainFilter.filterSettingData.genreMovieIds.add(28);
            }
          }
          widget.update(0);
          return;
        }
        mainFilter.filterSettingData.genreMovieIds.add(tileId as int);
        break;
      case(GlobalStrings.genreOfSeries):
        if (mainFilter.filterSettingData.genreSeriesIds.contains(tileId)){
          mainFilter.filterSettingData.genreSeriesIds.remove(tileId);
          mainFilter.filterSettingData.genreSeriesIds.remove(tileId);
          if(mainFilter.filterSettingData.genreSeriesIds.isEmpty){
            if (tileId == 10759){
              mainFilter.filterSettingData.genreSeriesIds.add(16);
            } else {
              mainFilter.filterSettingData.genreSeriesIds.add(10759);
            }
          }
          widget.update(0);
          return;
        }
        mainFilter.filterSettingData.genreSeriesIds.add(tileId as int);
        break;
      case(GlobalStrings.provider):
        if (mainFilter.filterSettingData.mediaProviderIds.contains(tileId)){
          mainFilter.filterSettingData.mediaProviderIds.remove(tileId);
          mainFilter.filterSettingData.mediaProviderIds.remove(tileId);
          if(mainFilter.filterSettingData.mediaProviderIds.isEmpty){
            if (tileId == 8){
              mainFilter.filterSettingData.mediaProviderIds.add(9);
            } else {
              mainFilter.filterSettingData.mediaProviderIds.add(8);
            }
          }
          widget.update(0);
          return;
        }
        mainFilter.filterSettingData.mediaProviderIds.add(tileId as int);
        break;
      case(GlobalStrings.mediaTyp):
        if (mainFilter.filterSettingData.mediaTypes.contains(tileId)){
          mainFilter.filterSettingData.mediaTypes.remove(tileId);
          mainFilter.filterSettingData.mediaTypes.remove(tileId);
          if(mainFilter.filterSettingData.mediaTypes.isEmpty){
            if (tileId == "movie"){
              mainFilter.filterSettingData.mediaTypes.add("tv");
            } else {
              mainFilter.filterSettingData.mediaTypes.add("movie");
            }
          }
          widget.update(0);
          return;
        }
        mainFilter.filterSettingData.mediaTypes.add(tileId as String);
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