import 'package:flutter/material.dart';

import '../class/Media.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<String> Temp = [
    "Liste mit Erik",
    "Liste mit Kristina",



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
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
                  print("hey");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
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
                  print("hey");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
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
                height: Temp.length * 113+20,
                width: 400,
                child: FutureBuilder(
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (Temp == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading"),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: Temp.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  print("hey");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    color: Colors.white,
                                  ),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: Size(100, 100),
                                            primary: Colors.lightBlueAccent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)))),
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        Temp[index],
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        });
                  }
                }),
              ),
            ]))));
  }
}
