import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/AppData.dart';
import 'package:watchlist/utils/myThemes.dart';

import '../../backend/Controller.dart';
import '../../utils/SnackBar.dart';



class modifyProfil extends StatefulWidget {
  final Function resetStateOfParent;
  const modifyProfil({Key? key, required this.resetStateOfParent}) : super(key: key);

  @override
  State<modifyProfil> createState() => _modifyProfilState();

}

class _modifyProfilState extends State<modifyProfil> {
  late TextEditingController textfieldController;
  AppData appData = AppData();

  @override
  void initState(){
    textfieldController = TextEditingController();
  }

  @override
  void dispose(){
    textfieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profil bearbeiten"),
       // backgroundColor: Colors.black12,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
         // color: kDarkPrimaryColor,

          padding: EdgeInsets.only(left: 30, right: 30, top: 25),
          child: Center(
            child: Column(
              children: [
                themeProvider.isDarkMode ? Image.asset("lib/assets/maxl250weiss.png", width: MediaQuery.of(context).size.width*0.4) : Image.asset("lib/assets/maxl250.png",
                                width: MediaQuery.of(context).size.width*0.4),
                          const SizedBox(
                            height: 25,
                          ),
                Row(children: [
                  Text("Anzeigename: ",
                      style: TextStyle(
                        //color: kLightPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],),
                          Row(
                            children: [
                                  Text(appData.userData.userName,
                                      style: TextStyle(
                                          //color: kLightPrimaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      onPressed: () async{
                                        final name = await EditButtonPressed();
                                        if(name == null  || name.isEmpty){
                                          Utils.showSnackBar("Username fehlt");
                                        }
                                        else if(name.length > 20){
                                           Utils.showSnackBar("Username zu lang");
                                        }
                                        else
                                          {
                                            appData.userData.userName = name;
                                            updateUserNameForUser();
                                            widget.resetStateOfParent();
                                            setState(() {});
                                          }

                                      },
                                      icon: Icon(Icons.edit))


                            ],
                          ),
                Text(
                  "Dieser Name wird primär angezeigt in der Freundesliste",
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.5), ////DARKTHEME !!!!
                      fontSize: 16
                  ),
                ),
                SizedBox(height: 30,),
                Row(children: [
                  Text("Benutzername: ",
                      style: TextStyle(
                        //     color: kLightPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],),
                Row(
                  children: [

                    Text(appData.userData.userAccountName,
                        style: TextStyle(
                      //      color: kLightPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.red.withOpacity(0),), enableFeedback: false,)
                    //SizedBox(width: MediaQuery.of(context).size.width*0.11,)
                  ],
                ),
                Text(
                  "Dieser Name ist dein Nutzername und der Name über den du gefunden werden kannst",
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                      fontSize: 16
                  ),
                )
              ],
            ),
          ),
        ),
      ));

  }

  Future<String?> EditButtonPressed() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("Dein Anzeigename"),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: "Geben Sie ihren Anzeigenamen ein"),
              controller: textfieldController,
            ),
            actions: [
              TextButton(onPressed: (){ onCancel();}, child: Text("CANCEL")),
              TextButton(onPressed: (){ onSubmitted();}, child: Text("SUBMIT"))
            ],
          ),
        );

  void onSubmitted() {
    setState(() {
      Navigator.of(context).pop(textfieldController.text);

      });
  }
  void onCancel() {
    setState(() {
      textfieldController.text = "";
      Navigator.pop(context);
    });
  }
  }




