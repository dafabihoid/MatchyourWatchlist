import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:watchlist/DTOs/FriendsDTO.dart';

import '../class/Friends.dart';

class WatchlistSingleton {
  static final WatchlistSingleton watchlistSingleton = WatchlistSingleton._internal();

  List<FriendsDTO> addedFriends = List.empty(growable: true);

  factory WatchlistSingleton(){
    return watchlistSingleton;
  }

  Map<String, dynamic> friendIdsToJson() => {
    'friendsForNewWatchlist': getFriendIdsFromList(),
  };

  List<String> getFriendIdsFromList(){
    List<String> friendIds = [];
    for (var element in addedFriends) {
      friendIds.add(element.UserID);
    }
    return friendIds;
  }

  WatchlistSingleton._internal();

}