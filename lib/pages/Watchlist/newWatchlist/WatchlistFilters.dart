import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/Widgets/FilterList.dart';

class WatchlistFilters extends StatefulWidget {
  const WatchlistFilters({Key? key}) : super(key: key);

  @override
  State<WatchlistFilters> createState() => _WatchlistFiltersState();
}

class _WatchlistFiltersState extends State<WatchlistFilters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(""),
        //    backgroundColor: Colors.black12,
      ),
      body: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView (
            child: Column (
              children: [
                FilterList()
              ],
            ),
          )
      ),
    );
  }


}
