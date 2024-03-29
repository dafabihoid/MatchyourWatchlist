import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/utils/myThemes.dart';

import '../../utils/ButtonsProvider.dart';



class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final buttonProvider = Provider.of<ButtonsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("App Einstellungen"),
        //backgroundColor: kDarkPrimaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(children: [
                Text("Darkmode", style: TextStyle(fontSize: 20),),
                Spacer(),
                Switch.adaptive(value: themeProvider.isDarkMode,
                    onChanged: (onChanged){
                      final provider = Provider.of<ThemeProvider>(context, listen: false);

                      provider.toggleTheme(onChanged);

                    }),
              ],),
              Row(children: [
                Text("Buttons", style: TextStyle(fontSize: 20),),
                Spacer(),
                Switch.adaptive(value: buttonProvider.ButtonsActivated,
                    onChanged: (onChanged){
                      final provider = Provider.of<ButtonsProvider>(context, listen: false);
                      provider.toggleButtons(onChanged);

                    })
              ],),
            ],
          )
      ),
    );
  }
}
