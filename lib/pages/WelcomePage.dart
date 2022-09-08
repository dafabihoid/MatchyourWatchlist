import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/pages/mainPage.dart';
import 'package:watchlist/pages/Homepage.dart';

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
                SizedBox(
                  height: 30,
                ),
                Text("MatchYourWatchlist",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 50,
                ),
              ])),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              TextField(
                onChanged: (value) => setState(() => tmp_password = value),
                decoration: InputDecoration(
                  hintText: "Passwort",
                  prefixIcon: Icon(
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
              SizedBox(
                height: 12,
              ),
              Text(
                "Passwort vergessen?",
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: Color(0xFF0069FE),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    },
                    child: Text(
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
