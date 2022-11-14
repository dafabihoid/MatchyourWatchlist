import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/CardProvider.dart';
import '../mainPage.dart';
import 'WelcomePage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();

}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Navigatetohome();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardProvider>(context);
    provider.getMovies.forEach((element) {
      Future.wait([
        precacheImage(NetworkImage(element.cover), context),
      ]);
    });

    return Scaffold(
        body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/assets/LogoSchrift.png"),
                      )),
            ))
    );

  }

   Navigatetohome()async {
    await Future.delayed(Duration(milliseconds: 1500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
   }
}