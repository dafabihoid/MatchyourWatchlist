class FilterData {
  String headerValue;
  List<FilterDataItem> filterItems;
  bool isExpanded;

  FilterData({
    required this.headerValue,
    required this.filterItems,
    this.isExpanded = false,
  });
}

class FilterDataItem {
  String filterItemId;
  String filterItemValue;

  FilterDataItem ({
    required this.filterItemId,
    required this.filterItemValue,
  });
}