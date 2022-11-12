import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<Item> _data = generateItems(3);
  final List<String> items = [
    "Fantasy",
    "Drama",
    "Komödie",
  ];

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
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Column(
              children: [
                ListTile(
                  title: Text(item.headerValue),
                ),
              ]
            );
          },
          body: Column (
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
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                    //  tileColor: index % 2 == 0 ? Color(0xFFEEEEEE) : Colors.white,
                      title: Text(
                        items[index],
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

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  List<String> headers = ["Genre", "Anbieter", "Sprachen"];

  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: headers[index],
      expandedValue: 'This is item number $index',
    );
  });
}