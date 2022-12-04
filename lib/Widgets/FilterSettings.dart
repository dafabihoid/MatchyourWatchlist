import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/Widgets/FilterTile.dart';
import 'package:watchlist/class/Language.dart';

import 'package:provider/provider.dart';
import '../../class/FilterData.dart';
import '../../class/Genre.dart';
import '../../class/MediaProvider.dart';
import '../../utils/BackendDataProvider.dart';
import '../../utils/GlobalString.dart';

class FilterSettings extends StatefulWidget {
  const FilterSettings({Key? key}) : super(key: key);

  @override
  State<FilterSettings> createState() => _FilterSettingsState();
}

class _FilterSettingsState extends State<FilterSettings> {
  List<FilterData> data = List.empty();
  late BackendDataProvider backendDataProvider;
  MainFilter mainFilter = MainFilter();

  void update(int noUse){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(data.isEmpty){
      backendDataProvider = Provider.of<BackendDataProvider>(context);
      //fillFilterList();
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
              const ListTile(
                title: Text("Alles auswählen"),
                trailing: Icon(
                  Icons.check_box_outline_blank_outlined,
                  // color: Colors.black,
                ),
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

    List<MediaProvider> providers = backendDataProvider.importantProviders;
    providers.forEach((element) {
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
