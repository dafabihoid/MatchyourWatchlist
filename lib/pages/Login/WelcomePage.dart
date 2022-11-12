import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/mainPage.dart';
import 'package:watchlist/pages/Homepage/Homepage.dart';

import '../../utils/CardProvider.dart';
import 'AuthPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<CardProvider>(context);

    provider.getMovies.forEach((element) {
      Future.wait([
        precacheImage(NetworkImage(element.cover), context),
      ]);
    });

    return Scaffold(

        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainPage();
         }
        return AuthPage();
          },
        )
    );
  }
}


