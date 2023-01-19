class FilterSettingData {
  String languageId = "en";
  List<int> genreMovieIds = [];
  List<int> genreSeriesIds = [];
  List<int> mediaProviderIds = [];
  List<String> mediaTypes = ["movie", "tv"];

  FilterSettingData({
    required this.languageId,
    required this.genreMovieIds,
    required this.genreSeriesIds,
    required this.mediaProviderIds,
    required this.mediaTypes
  });
}