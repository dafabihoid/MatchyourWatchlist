import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Theme.dart';

class modifyProfil extends StatefulWidget {
  const modifyProfil({Key? key}) : super(key: key);

  @override
  State<modifyProfil> createState() => _modifyProfilState();
}

class _modifyProfilState extends State<modifyProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profil bearbeiten"),
       // backgroundColor: Colors.black12,
      ),
      body: Container(
       // color: kDarkPrimaryColor,
        height: double.infinity,
        padding: EdgeInsets.only(left: 35, right: 35, top: 25),
        child: Center(
          child: Column(
            children: [
                         Image.asset("lib/assets/maxl250.png",
                              width: MediaQuery.of(context).size.width*0.4),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Text("Anzeigename:",
                                style: TextStyle(
                                    //color: kLightPrimaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            Spacer(),
                            Text("Testname",
                                style: TextStyle(
                                    //color: kLightPrimaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            IconButton(onPressed: (){EditButtonPressed();}, icon: Icon(Icons.edit))
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
              Row(
                children: [
                  Text("Benutzername:",
                      style: TextStyle(
                     //     color: kLightPrimaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("@Testname",
                      style: TextStyle(
                    //      color: kLightPrimaryColor,
                          fontSize: 22,
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
      ));

  }

  EditButtonPressed() {
    print("Test");
  }
}
