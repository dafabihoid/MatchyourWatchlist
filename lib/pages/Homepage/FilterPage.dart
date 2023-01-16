import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Widgets/FilterSettings.dart';
import '../../utils/CardProvider.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    return WillPopScope(
        onWillPop: () async {
          checkFilterSettings();
          cardProvider.clearMediaData();
          cardProvider.initializeData();
          while(true){
            if(cardProvider.movies.isNotEmpty){
              await Future.delayed(const Duration(milliseconds: 100),(){});
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

  void checkFilterSettings(){

  }
}




