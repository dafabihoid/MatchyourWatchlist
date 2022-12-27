class AppData {
  static final AppData _appData = AppData._internal();

  bool filterSettingsAreAvailable = false;
  String appLanguage = "de-de";

  factory AppData(){
    return _appData;
  }

  AppData._internal();

}