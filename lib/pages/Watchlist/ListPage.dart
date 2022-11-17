import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/Watchlist/BereitsGesehen.dart';
import 'package:watchlist/pages/Watchlist/Watchlist.dart';


import '../../DTOs/ListDTO.dart';
import '../../class/Media.dart';
import '../../utils/myThemes.dart';
import 'EigeneWatchlist.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(25),
            child: SingleChildScrollView(
                child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "Watchlists",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>EigeneWatchlist()));
                },
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(width: 1),
                    color: themeProvider.isDarkMode ? MyThemes.kDarkSecondaryColor : Colors.white
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 100),
                            primary: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)))),
                        onPressed: () {},
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Eigene Watchlist",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>BereitsGesehen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(//color: kDarkPrimaryColor,
                       width: 1),
                      color: themeProvider.isDarkMode ? MyThemes.kDarkSecondaryColor : Colors.white
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 100),
                            primary: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)))),
                        onPressed: () {},
                        child: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Bereits gesehen",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: ErikApi.ErikApiListe.length * 113+20,
                width: 400,
                child: FutureBuilder(
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (ErikApi.ErikApiListe == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading"),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: ErikApi.ErikApiListe.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Watchlist(listTDO: ErikApi.ErikApiListe[index]);
                        });
                  }
                }),
              ),
            ]))));
  }

}
