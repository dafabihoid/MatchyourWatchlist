import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/myThemes.dart';
import 'BereitsGesehenPage.dart';

class BereitsGesehenWidget extends StatelessWidget {
  const BereitsGesehenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BereitsGesehen()));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              //color: kDarkPrimaryColor,
                width: 1),
            color: themeProvider.isDarkMode
                ? MyThemes.kDarkSecondaryColor
                : Colors.white),
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
    );
  }
}
