import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/AppData.dart';
import 'package:watchlist/Singleton/BackendDataProvider.dart';
import 'package:watchlist/Singleton/ListCreationFilter.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/Singleton/MainFilter.dart';
import 'package:watchlist/Singleton/Watchlists.dart';
import 'package:watchlist/backend/Controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchlist/pages/Profile/AppSettings.dart';
import 'package:watchlist/pages/Profile/modifyProfil.dart';
import 'package:watchlist/pages/Profile/myFriends.dart';
import 'package:watchlist/utils/CardProvider.dart';

import '../../utils/AppGeneralUtils.dart';
import '../../utils/myThemes.dart';
import '../../DTOs/MediaDTO.dart';
import '../Login/AuthPage.dart';
import '../mainPage.dart';


class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  AppData appData = AppData();
  final controller = TextEditingController();
  late Future<MediaDTO> futureMovieDTO;
  //String? AccountEmail = FirebaseAuth.instance.currentUser?.email;
  String? AccountEmail = "mail";

  void resetState(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        //color: kDarkPrimaryColor,
        height: double.infinity,
        padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Column(
                          children: [
                        const SizedBox(height:30,),
                        Container(
                          child: themeProvider.isDarkMode ? Image.asset("lib/assets/maxl250weiss.png", width: MediaQuery.of(context).size.width*0.3) : Image.asset("lib/assets/maxl250.png",
                              width: MediaQuery.of(context).size.width*0.3)
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Text(appData.userData.userName,
                            style: const TextStyle(
                             //   color: kLightPrimaryColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 5,
                            ),
                         Text(appData.userData.userAccountName!,
                            style: const TextStyle(
                         //       color: kLightPrimaryColor,
                                fontSize: 14,
                                )),
                        const SizedBox(
                          height: 30,
                        ),
                      ])),
                  buildSettings("Profil bearbeiten",1),
                  SizedBox(height: 15,),
                  buildSettings("Meine Freunde",2),
                  SizedBox(height: 15,),
                  buildSettings("App Einstellungen",3),
                  SizedBox(height: 15,),
                  buildSignOutButton("Abmelden",context),
                ],
              ),
            ));
  }

  Widget buildSettings(String text, int PageID){
    String ButtonText = text;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(Size(5,45),),
            backgroundColor: MaterialStateProperty.all<Color>(MyThemes.kAccentColor),
             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
             RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
           ),
          ),
          ),
          onPressed: () async {
            if(PageID == 1){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>modifyProfil(resetStateOfParent: resetState,)));
            }
            else if(PageID == 2){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>myFriends()));
            }
            else if(PageID == 3){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>AppSettings()));
            }
          },
          child: Text(
            ButtonText,
            style: TextStyle(
              color: themeProvider.isDarkMode ?Colors.white : Colors.black,
              fontSize: 20,
            ),
          ),

        ));

}
}
Widget buildSignOutButton(String text, context){
    String ButtonText = text;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final cardProvider = Provider.of<CardProvider>(context);
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(5,45),),
               backgroundColor: MaterialStateProperty.all<Color>(MyThemes.kAccentColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              )
            )
          ),
          onPressed: () {
            AppGeneralUtils.resetAllData();
            cardProvider.resetCardProvider();
            FirebaseAuth.instance.signOut();
          },
          child: Text(
            ButtonText,
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white: Colors.black ,
              fontSize: 20,
            ),
          ),

        )
    );
}




