import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/myThemes.dart';
import 'EigeneWatchlistPage.dart';

class EigeneWatchlistWidget extends StatelessWidget {
  const EigeneWatchlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
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
    );
  }
}
