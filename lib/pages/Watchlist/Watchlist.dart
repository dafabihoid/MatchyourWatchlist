import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/DTOs/ListDTO.dart';
import 'package:watchlist/utils/myThemes.dart';

import '../../utils/Theme.dart';

class Watchlist extends StatelessWidget {
  final ListDTO listTDO;
  const Watchlist({Key? key, required this.listTDO}) : assert(listTDO != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        InkWell(
          onTap: () {

          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                    color: Colors.black, width: 1),
                color:  themeProvider.isDarkMode ? kDarkSecondaryColor : Colors.white
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
                  onPressed: () {
                    print(listTDO.Id);
                  },
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
                  listTDO.WatchlistName,
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
  }
}
