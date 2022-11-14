import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/utils/myThemes.dart';

import '../../utils/Theme.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("App Einstellungen"),
        //backgroundColor: kDarkPrimaryColor,
      ),
      body: Center(
          child: Column(
            children: [
              Switch.adaptive(value: themeProvider.isDarkMode,
                  onChanged: (onChanged){
                final provider = Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(onChanged);

              })
            ],
          )
      ),
    );
  }
}