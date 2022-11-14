import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      //  backgroundColor: Colors.black12,
        title: const Text("Suchen"),
      ),

      body: Container(
        padding: EdgeInsets.all(15),
        child: TextField(
          //controller: SearchController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "Film Title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black)
            )
          ),
        )
      ),
    );
  }
}
