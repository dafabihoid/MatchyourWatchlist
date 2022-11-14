import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/backend/Controller.dart';
import 'package:watchlist/class/Language.dart';
import 'package:watchlist/class/Language.dart';

import '../class/Genre.dart';
import '../class/Provider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<FilterData> data = generateFilterDataList();
  int filterIndex = 0;

  @override
  Widget build(BuildContext context) {
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
            key: Key('a'),
            children: [
              const Divider(thickness: 2, indent: 15, endIndent: 20,),
              const ListTile(
                title: Text("Alles auswählen"),
                trailing: Icon(
                  Icons.sticky_note_2_outlined,
                 // color: Colors.black,
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data[filterIndex].filterItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      key: Key(data[filterIndex].filterItems[index].filterItemId),
                      //tileColor: index % 2 == 0 ? const Color(0xFFEEEEEE) : Colors.white,
                      title: Text(
                        data[filterIndex].filterItems[index].filterItemValue,
                      ),
                      trailing: const Icon(
                        Icons.sticky_note_2_outlined,
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

  Future<List<Genre>> genres = fetchAllGenres(mediaType);
  genres.then((result) {
    for (Genre element in result){
      filterDataItems.add(FilterDataItem(filterItemId: '${element.genreId}', filterItemValue: element.genreName));
    }
  });

  return filterDataItems;
}

List<FilterDataItem> getFilterDataItemsFromProviders(){
  List<FilterDataItem> filterDataItems = [];

  Future<List<Provider>> genres = fetchImportantProvider();
  genres.then((result) {
    for (Provider element in result){
      filterDataItems.add(FilterDataItem(filterItemId: '${element.providerId}', filterItemValue: element.providerName));
    }
  });

  return filterDataItems;
}

List<FilterDataItem> getFilterDataItemsFromLanguages(){
  List<FilterDataItem> filterDataItems = [];

  Future<List<Language>> genres = fetchAllLanguages();
  genres.then((result) {
    for (Language element in result){
      filterDataItems.add(FilterDataItem(filterItemId: element.languageId, filterItemValue: element.language));
    }
  });

  return filterDataItems;
}

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

