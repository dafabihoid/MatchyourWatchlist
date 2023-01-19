import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/pages/main.dart';

import '../../Widgets/FilterSettings.dart';
import '../../class/FilterSettingData.dart';
import '../../utils/CardProvider.dart';


class FilterPage extends StatefulWidget {
  final Function callback;
  const FilterPage({Key? key, required this.callback}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  MainFilter mainFilter = MainFilter();
  late FilterSettingData filterSettingData;
  bool filterSettingDataLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (!filterSettingDataLoaded){
      filterSettingDataLoaded = true;
      filterSettingData = mainFilter.filterSettingData;
    }
    final cardProvider = Provider.of<CardProvider>(context);
    return WillPopScope(
        onWillPop: () async {
          if(!checkIfFilterSettingsChanged()){
            return true;
          }
          cardProvider.clearMediaData();
          cardProvider.initializeData();
          while(true){
            if(cardProvider.movies.isNotEmpty){
              await Future.delayed(const Duration(milliseconds: 100),(){});
              widget.callback();
              return true;
            }
            await Future.delayed(const Duration(milliseconds: 100),(){});
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Filter Einstellungen"),
          ),
          body: Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView (
                child: Column (
                  children: [
                    FilterSettings(),
                  ],
                ),
              )
          ),
        )
    );
  }

  bool checkIfFilterSettingsChanged(){
    int str1 = filterSettingData.hashCode;
    int str2 = mainFilter.filterSettingData.hashCode;
    if (filterSettingData.hashCode == mainFilter.filterSettingData.hashCode){
      return false;
    }
    return true;
  }
}




