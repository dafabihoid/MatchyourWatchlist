class AppData {
  static final AppData _appData = AppData._internal();

  bool filterSettingsAreAvailable = false;

  factory AppData(){
    return _appData;
  }

  AppData._internal();

}