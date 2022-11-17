import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/class/Language.dart';

import 'package:provider/provider.dart';
import '../../DTOs/FilterDTO.dart';
import '../../class/FilterData.dart';
import '../../class/Genre.dart';
import '../../class/MediaProvider.dart';
import '../../utils/BackendDataProvider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<FilterData> data = List.empty();
  late BackendDataProvider backendDataProvider;
  late FilterDTO filterSettings;
  int filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    if(data.isEmpty){
      backendDataProvider = Provider.of<BackendDataProvider>(context);
      data = generateFilterDataList();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter Settings"),
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
              item.headerValue == "Sprachen" ? const SizedBox():
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
                    return ListTile(
                      //key: Key(data[filterIndex].filterItems[index].filterItemId),
                      //tileColor: index % 2 == 0 ? const Color(0xFFEEEEEE) : Colors.white,
                      title: Text(
                        data[filterIndex].filterItems[index].filterItemValue,
                      ),
                      trailing: const Icon(
                        Icons.check_box_outlined,
                     //   color: Colors.black,
                      ),
                    );
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
    List<String> headers = ["Medien-Typ", "Genre der Filme", "Genre der Serien", "Provider", "Sprachen"];

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
      filterDataItems.add(FilterDataItem(filterItemId: '${element.genreId}', filterItemValue: element.genreName));
    });

    return filterDataItems;
  }

  List<FilterDataItem> getFilterDataItemsFromProviders(){
    List<FilterDataItem> filterDataItems = [];

    List<MediaProvider> providers = backendDataProvider.importantProviders;
    providers.forEach((element) {
      filterDataItems.add(FilterDataItem(filterItemId: '${element.providerId}', filterItemValue: element.providerName));
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




