import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    print("test");
    return firebaseApp;
  }

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
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
          //  if (snapshot.connectionState == ConnectionState.done) {
              return LoginPage();
         //   }
        //    return const Center(
        //      child: CircularProgressIndicator(),
        //    );

          },
        )
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {
  static Future<User?> loginUsingEmailandPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await  auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        print("No User found for that email");
      }
    }
    return user;
  }

  String tmp_password = "";
  bool isPasswordVisible = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Column(children: [
                  Image.asset("lib/assets/Logo.png",
                      width: MediaQuery.of(context).size.width * 0.3),
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
            TextField(
              controller: _emailController,
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
              controller: _passwordController,
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
                  onPressed: () => setState(
                          () => isPasswordVisible = !isPasswordVisible),
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
                  onPressed: () async {
                    User? user = await loginUsingEmailandPassword(email: _emailController.text, password: _passwordController.text, context: context);
                    print("test");
                    print(_emailController.text);
                    if(user != null){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()));
                    }



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
        ));
  }
}
