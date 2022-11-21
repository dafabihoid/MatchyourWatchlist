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

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<FilterData> data = List.empty();
  late BackendDataProvider backendDataProvider;
  MainFilter mainFilter = MainFilter();
  int filterIndex = 0;

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter Einstellungen"),
    //    backgroundColor: Colors.black12,
      ),

      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView (
          child: Column (
            children: [
              _buildPanel(),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        filterIndex = index;
        setState(() {
          data[filterIndex].isExpanded = !isExpanded;
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
                  itemCount: data[filterIndex].filterItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FilterTile(tileField: item.headerValue, tileId: data[filterIndex].filterItems[index].filterItemId, tileValue: data[filterIndex].filterItems[index].filterItemValue, update: update,);
                  }
              ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  void fillFilterList(){
    backendDataProvider.allGenresMovies.forEach((element) {
      mainFilter.addGenreMovie(element.genreId);
    });
    backendDataProvider.allGenresSeries.forEach((element) {
      mainFilter.addGenreSeries(element.genreId);
    });
    backendDataProvider.importantProviders.forEach((element) {
      mainFilter.addMediaProvider(element.providerId);
    });
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




