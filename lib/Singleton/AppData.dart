import 'package:watchlist/DTOs/UserDataDTO.dart';

import '../DTOs/FriendsDTO.dart';
import '../backend/Controller.dart';

class AppData {
  static final AppData _appData = AppData._internal();

  bool filterSettingsAreAvailable = false;
  bool userBackendDataAvailable = false;
  bool homePageLoading = true;
  bool friendDataAvailable = false;
  String appLanguage = "de-de";
  UserDataDTO userData = UserDataDTO(userId: "", userName: "", userAccountName: "");
  int mainListId = -1;
  int alreadyWatchedListId = -1;

  List<FriendsDTO> Friendrequests = List.empty();
  List<FriendsDTO> Friends = List.empty();
  List<FriendsDTO> Sentrequests = List.empty();


  factory AppData(){
    return _appData;
  }

  void resetData(){
    filterSettingsAreAvailable = false;
    userBackendDataAvailable = false;
    homePageLoading = true;
    appLanguage = "de-de";
    userData = UserDataDTO(userId: "", userName: "", userAccountName: "");
    mainListId = -1;
    alreadyWatchedListId = -1;
  }

  Future<List<FriendsDTO>> getAllFriendRequests(){
    Future<List<FriendsDTO>> friendRequests = getAllRequests("Test2"); //userData.userId
    friendRequests.then((result) {});
    return friendRequests;
  }
  Future<List<FriendsDTO>> getAllFriendsList(){
    Future<List<FriendsDTO>> allFriends = getAllFriends("Test1"); //userData.userId
    allFriends.then((result) {});
    return allFriends;
  }
  Future<List<FriendsDTO>> getAllSentRequestsList(){
    Future<List<FriendsDTO>> sentRequests = getAllSentRequests("Test1"); //userData.userId
    sentRequests.then((result) {});
    return sentRequests;
  }


  AppData._internal();



}
