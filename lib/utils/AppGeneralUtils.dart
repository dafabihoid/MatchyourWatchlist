import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/WatchlistSingleton.dart';
import 'package:watchlist/utils/CardProvider.dart';

import '../Singleton/AppData.dart';
import '../Singleton/ListCreationFilter.dart';
import '../Singleton/MainFilter.dart';
import '../Singleton/Watchlists.dart';
import '../Singleton/BackendDataProvider.dart';

class AppGeneralUtils{
  static void resetAllData(){
    AppData().resetData();
    BackendDataProvider().clearData();
    ListCreationFilter().resetData();
    MainFilter().resetData();
    Watchlists().resetData();
    WatchlistSingleton().resetData();
  }
}