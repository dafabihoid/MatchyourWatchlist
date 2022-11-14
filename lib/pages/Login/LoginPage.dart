import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/pages/Login/ForgotPasswordPage.dart';
import 'package:watchlist/utils/Theme.dart';

import '../../utils/SnackBar.dart';
import '../mainPage.dart';

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
        height: double.infinity,
     //   color: kDarkPrimaryColor,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Column(children: [
                  SizedBox(height:65,),
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
                        //  color: kLightPrimaryColor,
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
               //   color: kLightPrimaryColor,
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
                //  color: kLightPrimaryColor,
                ),
                suffixIcon: IconButton(
                  icon: isPasswordVisible
                      ? const Icon(
                    Icons.visibility_off,
                //    color: kLightPrimaryColor,
                  )
                      : const Icon(
                    Icons.visibility,
                  //  color: kLightPrimaryColor,
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
            GestureDetector(
              child: const Text(
                "Passwort vergessen?",
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()))

            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                width: double.infinity,
                child: RawMaterialButton(
               //   fillColor: kAccentColor, !!!!!!!!!!!!
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  onPressed: () async {
                    signIn();
                   /* Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));*/
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                 //     color: kDarkPrimaryColor,
                      fontSize: 18,
                    ),
                  ),
                )),
            SizedBox(height: 10,),
            RichText(text: TextSpan(
                style: TextStyle(//color: kLightPrimaryColor,
     fontSize: 15),
                text: 'No account? ',
                children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Sign Up',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary
                      )
                  )
                ]
            ))
          ],
        )));
  }

  void signIn() async {
    try{
      UserCredential user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      )) as UserCredential;
      //print(user.user?.uid);

    } on FirebaseAuthException catch(e) {
      Utils.showSnackBar(e.message);
    }


  }

  //fürn Erik
  void signInAnonym() async {
    User? user = FirebaseAuth.instance.signInAnonymously() as User?;

    if (user != null) {

    }
  }
}