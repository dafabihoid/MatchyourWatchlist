import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:watchlist/DTOs/FriendsDTO.dart';

import '../class/Friends.dart';
import 'AppData.dart';

class WatchlistSingleton {
  static final WatchlistSingleton watchlistSingleton = WatchlistSingleton._internal();

  List<FriendsDTO> addedFriends = List.empty(growable: true);

  factory WatchlistSingleton(){
    return watchlistSingleton;
  }

  void resetData(){
    addedFriends = List.empty(growable: true);
  }

  Map<String, dynamic> friendIdsToJson() => {
    'friendsForNewWatchlist': getFriendIdsFromList(),
  };

  List<String> getFriendIdsFromList(){
    List<String> friendIds = [];
    for (var element in addedFriends) {
      if(!friendIds.contains(element.UserID)){
        friendIds.add(element.UserID);
      }
      if(!friendIds.contains(element.FriendID)){
        friendIds.add(element.FriendID);
      }
    }
    friendIds.remove(AppData().userData.userId);
    return friendIds;
  }

  WatchlistSingleton._internal();

}