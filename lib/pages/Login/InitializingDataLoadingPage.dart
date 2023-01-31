import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/DTOs/FriendsDTO.dart';
import 'package:watchlist/Singleton/AppData.dart';
import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/Singleton/ListCreationFilter.dart';
import 'package:watchlist/utils/AppGeneralUtils.dart';
import 'package:watchlist/utils/GlobalString.dart';

import '../../DTOs/UserDataDTO.dart';
import '../../Singleton/MainFilter.dart';
import '../../backend/Controller.dart';
import '../../utils/CardProvider.dart';
import '../mainPage.dart';
import 'AuthPage.dart';

class InitializingDataLoadingPage extends StatefulWidget {
  const InitializingDataLoadingPage({Key? key}) : super(key: key);

  @override
  State<InitializingDataLoadingPage> createState() => _InitializingDataLoadingPageState();

}

class _InitializingDataLoadingPageState extends State<InitializingDataLoadingPage> {
  AppData appData = AppData();
  BackendDataProvider backendDataProvider = BackendDataProvider();
  bool initializingFinished = false;
  bool started = false;
  bool resetToLoginPage = false;

  @override
  Widget build(BuildContext context) {
    if(!started){
      started = true;
      startInitialization();
    }

    return Scaffold(
      body: Center(
        child: !initializingFinished ?
          resetToLoginPage ?
          AuthPage()
          :
          Column (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color> (Colors.deepPurpleAccent),
              )
            ],
          ) :
          MainPage(),
      ),
    );
  }

  void startInitialization() async{
    if(appData.userBackendDataAvailable){
      await createNewUserWithDetails(FirebaseAuth.instance.currentUser?.uid, appData.userData.userName);
    }
    else {
      loadUserData();
    }
    loadFriends();
    loadFilterSettings();
  }

  void loadUserData() async{
    Future<UserDataDTO?> futureUserDataDTO = getUserDataByUserId(FirebaseAuth.instance.currentUser!.uid);
    await futureUserDataDTO.then((value) => {
      if(value == null){
        AppGeneralUtils.resetAllData(),
      } else {
        appData.userData = value,
        appData.userBackendDataAvailable = true
      }}
    );
  }
  void loadFriends() async{

    Future<List<FriendsDTO>> FriendRequests = appData.getAllFriendRequests();
    await FriendRequests.then((value) => appData.Friendrequests = value);
    Future<List<FriendsDTO>> Friends = appData.getAllFriendsList();
    await Friends.then((value) => appData.Friends = value);
    Future<List<FriendsDTO>> SentRequests = appData.getAllSentRequestsList();
    await SentRequests.then((value) => appData.Sentrequests = value);

    appData.friendDataAvailable = true;

  }

  void loadFilterSettings() async {
    int initializingStartTime = DateTime.now().millisecondsSinceEpoch;
    while(!appData.userBackendDataAvailable || backendDataProvider.importantProviders.isEmpty || backendDataProvider.allGenresMovies.isEmpty || backendDataProvider.allGenresSeries.isEmpty){
      await Future.delayed(const Duration(milliseconds: 300),(){});
      if(checkIfExitIsNeeded(initializingStartTime)){
        exitToLoginWithDataReset();
        return;
      }
    }

    loadFriends();
    backendDataProvider.loadWatchlists();

    MainFilter mainFilter = MainFilter();
    ListCreationFilter listCreationFilter = ListCreationFilter();

    mainFilter.resetData();

    backendDataProvider.allGenresMovies.forEach((element) {
      mainFilter.addGenreMovie(element.genreId);
    });
    backendDataProvider.allGenresSeries.forEach((element) {
      mainFilter.addGenreSeries(element.genreId);
    });
    backendDataProvider.importantProviders.forEach((element) {
      mainFilter.addMediaProvider(element.providerId);
    });

    backendDataProvider.allGenresMovies.forEach((element) {
      listCreationFilter.addGenreMovie(element.genreId);
    });
    backendDataProvider.allGenresSeries.forEach((element) {
      listCreationFilter.addGenreSeries(element.genreId);
    });
    backendDataProvider.importantProviders.forEach((element) {
      listCreationFilter.addMediaProvider(element.providerId);
    });

    initializingStartTime = DateTime.now().millisecondsSinceEpoch;
    while(backendDataProvider.listWithMediaDTOList.isEmpty || !appData.friendDataAvailable){
      await Future.delayed(const Duration(milliseconds: 200),(){});
      if(checkIfExitIsNeeded(initializingStartTime)){
        exitToLoginWithDataReset();
        return;
      }
    }
    await Future.delayed(const Duration(milliseconds: 100),(){});

    appData.mainListId = checkForListTypeAndReturnListId(GlobalStrings.listTypeFlagMainList);
    appData.alreadyWatchedListId = checkForListTypeAndReturnListId(GlobalStrings.listTypeFlagAlreadyWatchedList);

    appData.filterSettingsAreAvailable = true;
    initializingFinished = true;
    setState(() {});
  }

  int checkForListTypeAndReturnListId(String checkForListType){
    BackendDataProvider backendDataProvider = BackendDataProvider();
    for (var element in backendDataProvider.listWithMediaDTOList) {
        if(element.listType == checkForListType){
          return element.listId;
        }
    }
    return -1;
  }

  bool checkIfExitIsNeeded(int startTime){
    if(DateTime.now().millisecondsSinceEpoch - startTime > 30000){
      return true;
    }
    return false;
  }

  void exitToLoginWithDataReset(){
    AppGeneralUtils.resetAllData();
    FirebaseAuth.instance.signOut();
    resetToLoginPage = true;
    setState(() {});
  }
}
