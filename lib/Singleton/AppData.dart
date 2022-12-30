class AppData {
  static final AppData _appData = AppData._internal();

  bool filterSettingsAreAvailable = false;
  bool userBackendDataAvailable = false;
  String appLanguage = "de-de";
  String userId = "";
  String userName = "";
  String userDisplayName = "";
  int mainListId = -1;
  int isAlreadyWatchedListId = -1;

  factory AppData(){
    return _appData;
  }

  AppData._internal();

}