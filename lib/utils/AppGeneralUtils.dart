import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/utils/CardProvider.dart';

import '../Singleton/AppData.dart';
import '../Singleton/ListCreationFilter.dart';
import '../Singleton/MainFilter.dart';
import '../Singleton/Watchlists.dart';
import '../Singleton/BackendDataProvider.dart';

class AppGeneralUtils{
  static void resetAllData(){
    AppData appData = AppData();
    appData.resetData();
    BackendDataProvider backendDataProvider = BackendDataProvider();
    backendDataProvider.clearData();
    ListCreationFilter listCreationFilter = ListCreationFilter();
    listCreationFilter.resetData();
    MainFilter mainFilter = MainFilter();
    mainFilter.resetData();
    Watchlists watchlists = Watchlists();
    watchlists.resetData();
  }
}