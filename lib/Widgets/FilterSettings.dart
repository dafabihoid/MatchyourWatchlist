import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/Widgets/FilterTile.dart';
import 'package:watchlist/class/Language.dart';
import 'package:watchlist/pages/main.dart';

import '../../class/FilterData.dart';
import '../../class/Genre.dart';
import '../../class/MediaProvider.dart';
import '../../utils/GlobalString.dart';
import '../Singleton/BackendDataProvider.dart';

class FilterSettings extends StatefulWidget {
  const FilterSettings({Key? key}) : super(key: key);

  @override
  State<FilterSettings> createState() => _FilterSettingsState();
}

class _FilterSettingsState extends State<FilterSettings> {
  List<FilterData> data = List.empty();
  BackendDataProvider backendDataProvider = BackendDataProvider();
  MainFilter mainFilter = MainFilter();
  bool headerClicked = false;

  void update(int noUse){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(data.isEmpty){
      data = generateFilterDataList();
    }

    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          data[index].isExpanded = !isExpanded;
        });
      },
      children: data.map<ExpansionPanel>((FilterData item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Column(
                children: [
                  ListTile(
                    key: Key(item.headerValue),
                    title: Text(item.headerValue),
                  ),
                ]
            );
          },
          body: Column (
            children: [
              const Divider(thickness: 2, indent: 15, endIndent: 20,),
              item.headerValue == GlobalStrings.language ? const SizedBox():
              ListTile(
                title: Text("Alles auswählen"),
                trailing: Icon(
                  headerClicked ? Icons.check_box_outlined : Icons.check_box_outline_blank_outlined,
                  // color: Colors.black,
                ),
                onTap: () {
                  headerClicked = !headerClicked;
                  changeAllFilterSettings(item.headerValue);
                  setState(() {});
                },
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item.filterItems.length,
                  itemBuilder: (BuildContext context, int listTileIndex) {
                    return FilterTile(tileField: item.headerValue, tileId: item.filterItems[listTileIndex].filterItemId, tileValue: item.filterItems[listTileIndex].filterItemValue, update: update,);
                  }
              ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  void changeAllFilterSettings(String headerValue){
    switch(headerValue){
      case(GlobalStrings.genreOfMovies):
        if (headerClicked){
          backendDataProvider.allGenresMovies.forEach((element) {
            mainFilter.addGenreMovie(element.genreId);
          });
          return;
        }
        mainFilter.filterSettingData.genreMovieIds = [];
        return;
      case(GlobalStrings.genreOfSeries):
        if (headerClicked){
          backendDataProvider.allGenresSeries.forEach((element) {
            mainFilter.addGenreSeries(element.genreId);
          });
          return;
        }
        mainFilter.filterSettingData.genreSeriesIds = [];
        return;
      case(GlobalStrings.provider):
        if (headerClicked){
          backendDataProvider.importantProviders.forEach((element) {
            mainFilter.addMediaProvider(element.providerId);
          });
          return;
        }
        mainFilter.filterSettingData.mediaProviderIds = [];
        return;
      case(GlobalStrings.mediaTyp):
        if (headerClicked){
          mainFilter.filterSettingData.mediaTypes = ["movie", "tv"];
          return;
        }
        mainFilter.filterSettingData.mediaTypes = [];
        return;
    }
  }

  List<FilterData> generateFilterDataList() {
    List<String> headers = [GlobalStrings.mediaTyp, GlobalStrings.genreOfMovies, GlobalStrings.genreOfSeries, GlobalStrings.provider, GlobalStrings.language];

    List<FilterData> filterData = [];

    filterData.add(
        FilterData(
            headerValue: headers[0],
            filterItems: [
              FilterDataItem(filterItemId: "movie", filterItemValue: "Film"),
              FilterDataItem(filterItemId: "tv", filterItemValue: "Serie"),
            ]
        )
    );

    filterData.add(
        FilterData(
            headerValue: headers[1],
            filterItems: getFilterDataItemsFromGenres("movie")
        )
    );

    filterData.add(
        FilterData(
            headerValue: headers[2],
            filterItems: getFilterDataItemsFromGenres("tv")
        )
    );

    filterData.add(
        FilterData(
            headerValue: headers[3],
            filterItems: getFilterDataItemsFromProviders()
        )
    );

    filterData.add(
        FilterData(
            headerValue: headers[4],
            filterItems: getFilterDataItemsFromLanguages()
        )
    );

    return filterData;
  }

  List<FilterDataItem> getFilterDataItemsFromGenres(String mediaType){
    List<FilterDataItem> filterDataItems = [];
    List<Genre> genres = [];

    if(mediaType == "movie"){
      genres = backendDataProvider.allGenresMovies;
    }
    else {
      genres = backendDataProvider.allGenresSeries;
    }

    genres.forEach((element) {
      filterDataItems.add(FilterDataItem(filterItemId: element.genreId, filterItemValue: element.genreName));
    });

    return filterDataItems;
  }

  List<FilterDataItem> getFilterDataItemsFromProviders(){
    List<FilterDataItem> filterDataItems = [];
    List<String> providerNamesContained = [];

    List<MediaProvider> providers = backendDataProvider.importantProviders;
    List<MediaProvider> tempProviders = [];

    providers.forEach((element) {
      if(!providerNamesContained.contains(element.providerName)){
        tempProviders.add(element);
        providerNamesContained.add(element.providerName);
      }
    });

    tempProviders.forEach((element) {
      filterDataItems.add(FilterDataItem(filterItemId: element.providerId, filterItemValue: element.providerName));
    });

    return filterDataItems;
  }

  List<FilterDataItem> getFilterDataItemsFromLanguages(){
    List<FilterDataItem> filterDataItems = [];

    List<Language> languages = backendDataProvider.allLanguages;
    languages.forEach((element) {
      filterDataItems.add(FilterDataItem(filterItemId: element.languageId, filterItemValue: element.language));
    });

    return filterDataItems;
  }
}
