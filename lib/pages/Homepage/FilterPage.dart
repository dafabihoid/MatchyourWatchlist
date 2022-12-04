import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/FilterSettings.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Filter Einstellungen"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView (
          child: Column (
            children: [
              FilterSettings(),
            ],
          ),
        )
      ),
    );
  }
}




