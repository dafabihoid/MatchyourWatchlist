import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../class/Friends.dart';

class WatchlistSingleton {
  static final WatchlistSingleton watchlistSingleton = WatchlistSingleton._internal();

  List<Friends> addedFriends = List.empty(growable: true);

  factory WatchlistSingleton(){
    return watchlistSingleton;
  }

  WatchlistSingleton._internal();

}