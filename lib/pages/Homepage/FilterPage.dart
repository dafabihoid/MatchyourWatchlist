import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/Singleton/MainFilter.dart';

import '../../Widgets/FilterSettings.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          checkFilterSettings();
          return true;
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

  void checkFilterSettings(){

  }
}




