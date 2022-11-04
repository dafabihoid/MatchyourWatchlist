import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'mainPage.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginPage({
    Key? key,
    required this.onClickedSignUp})
      : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {

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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.3),
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
                  onPressed: () =>
                      setState(
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
              style: TextStyle(color: Colors.blue, fontSize: 15),
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
                    //signIn();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )),
            SizedBox(height: 10,),
            RichText(text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 15),
                text: 'No account? ',
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Sign Up',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .secondary
                      )
                  )
                ]
            ))
          ],
        ));
  }

  void signIn() async {
    User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
    )) as User?;
    //print(_emailController.text);

  }

  //fürn Erik
  void signInAnonym() async {
    User? user = FirebaseAuth.instance.signInAnonymously() as User?;
    if (user != null) {

    }
  }
}