import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/Singleton/AppData.dart';

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

  }

  @override
  Widget build(BuildContext context) {
    Navigatetohome(context);

    return Scaffold(
        body: Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: MediaQuery.of(context).size.height*0.4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/LogoSchrift.png"),
                  )),
                ),
              ],
            ),
        ),
    );

  }

  Navigatetohome(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
   }
}
