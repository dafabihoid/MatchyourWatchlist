import 'package:watchlist/DTOs/UserDataDTO.dart';

class AppData {
  static final AppData _appData = AppData._internal();

  bool filterSettingsAreAvailable = false;
  bool userBackendDataAvailable = false;
  bool homePageLoading = true;
  String appLanguage = "de-de";
  UserDataDTO userData = UserDataDTO(userId: "", userName: "", userAccountName: "");
  int mainListId = -1;
  int alreadyWatchedListId = -1;


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

  AppData._internal();

}