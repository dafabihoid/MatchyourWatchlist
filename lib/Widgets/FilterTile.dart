import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/utils/GlobalString.dart';

class FilterTile extends StatefulWidget {
  final String tileField;
  final Object tileId;
  final String tileValue;

  const FilterTile({
    Key? key,
    required this.tileField,
    required this.tileId,
    required this.tileValue,
  }) : super(key: key);

  @override
  State<FilterTile> createState() => _FilterTile();
}

class _FilterTile extends State<FilterTile> {
  late String tileField;
  late Object tileId;
  late String tileValue;
  late Icon checkBox;
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
        if (mainFilter.genreMovieIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.genreOfSeries):
        if (mainFilter.genreSeriesIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.provider):
        if (mainFilter.mediaProviderIds.contains(tileId)){
          checkBox = const Icon(Icons.check_box_outlined);
          return;
        }
        checkBox = const Icon(Icons.check_box_outline_blank);
        break;
      case(GlobalStrings.mediaTyp):
        if (mainFilter.mediaTypes.contains(tileId)){
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
        mainFilter.languageId = tileId as String;
        break;
      case(GlobalStrings.genreOfMovies):
        if (mainFilter.genreMovieIds.contains(tileId)){
          mainFilter.genreMovieIds.remove(tileId);
          return;
        }
        mainFilter.genreMovieIds.add(tileId as int);
        break;
      case(GlobalStrings.genreOfSeries):
        if (mainFilter.genreSeriesIds.contains(tileId)){
          mainFilter.genreSeriesIds.remove(tileId);
          return;
        }
        mainFilter.genreSeriesIds.add(tileId as int);
        break;
      case(GlobalStrings.provider):
        if (mainFilter.mediaProviderIds.contains(tileId)){
          mainFilter.mediaProviderIds.remove(tileId);
          return;
        }
        mainFilter.mediaProviderIds.add(tileId as int);
        break;
      case(GlobalStrings.mediaTyp):
        if (mainFilter.mediaTypes.contains(tileId)){
          mainFilter.mediaTypes.remove(tileId);
          return;
        }
        mainFilter.mediaTypes.add(tileId as String);
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