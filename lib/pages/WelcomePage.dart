import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/pages/mainPage.dart';
import 'package:watchlist/pages/Homepage.dart';

import '../utils/CardProvider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String tmp_password = "";
  bool isPasswordVisible = true;

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
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Column(children: [
                Image.asset("lib/assets/Logo.png", width: screenwidth * 0.3),
                const SizedBox(
                  height: 30,
                ),
                const Text("MatchYourWatchlist",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 50,
                ),
              ])),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              TextField(
                onChanged: (value) => setState(() => tmp_password = value),
                decoration: InputDecoration(
                  hintText: "Passwort",
                  prefixIcon: const Icon(
                    Icons.vpn_key,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: isPasswordVisible
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                    onPressed: () =>
                        setState(() => isPasswordVisible = !isPasswordVisible),
                  ),
                ),
                obscureText: isPasswordVisible,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Passwort vergessen?",
                style: TextStyle(color: Colors.blue),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: const Color(0xFF0069FE),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const MainPage()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
