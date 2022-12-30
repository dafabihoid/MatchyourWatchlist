import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/DTOs/ListWithMediaDTO.dart';
import 'package:watchlist/pages/Watchlist/WatchlistDataPage.dart';
import 'package:watchlist/utils/GlobalString.dart';
import 'package:watchlist/utils/myThemes.dart';

class WatchlistTile extends StatelessWidget {
  final ListWithMediaDTO listWithMediaDTO;
  const WatchlistTile({Key? key, required this.listWithMediaDTO}) : assert(listWithMediaDTO != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            tabOnTile(context);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                    color: Colors.black, width: 1),
                color:  themeProvider.isDarkMode ? MyThemes.kDarkSecondaryColor : Colors.white
            ),
            width: double.infinity,
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 100),
                      primary: getColorByListType(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(7)))),
                  onPressed: () {
                    tabOnTile(context);
                  },
                  child: Icon(
                    getIconByListType(),
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  listWithMediaDTO.listName,
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

  void tabOnTile(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WatchlistDataPage(listWithMediaDTO: listWithMediaDTO,)));
  }

  IconData getIconByListType(){
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagMainList){
      return Icons.favorite;
    }
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagAlreadyWatchedList){
      return Icons.remove_red_eye;
    }
    return Icons.person;
  }

  Color getColorByListType(){
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagMainList){
      return Colors.blueAccent;
    }
    if(listWithMediaDTO.listType == GlobalStrings.listTypeFlagAlreadyWatchedList){
      return Colors.redAccent;
    }
    return Colors.lightBlueAccent;
  }
}
