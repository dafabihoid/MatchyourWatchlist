import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:watchlist/utils/myThemes.dart';

import '../../utils/SnackBar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
        iconTheme: IconThemeData(
        color: MyThemes.kLightPrimaryColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Reset Password", style: TextStyle(color: MyThemes.kLightPrimaryColor),),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(children: [
                          SizedBox(height: 30,),
                          Image.asset(themeProvider.isDarkMode
                              ? "lib/assets/Logo_white.png"
                              : "lib/assets/Logo.png",
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.3),
                          const SizedBox(
                            height: 30,
                          ),
                           Text(
                              "Geben Sie eine Email ein, um ihr Passwort zurückzusetzen.",
                             style: TextStyle(color: themeProvider.isDarkMode
                                 ? Colors.white
                                 : Colors.black, fontSize: 20),),
                           Row(
                             children: [
                               Text(
                                  "Hinweis: Mail könnte im Spam-Ordner landen!",
                                 style: TextStyle(color: themeProvider.isDarkMode
                                     ? Colors.white
                                     : Colors.black, fontSize: 16),),
                               Spacer()
                             ],
                           ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(
                                Icons.mail,
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? "Enter a valid email"
                                : null,
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Container(
                              width: double.infinity,
                              child: RawMaterialButton(
                                fillColor: MyThemes.kAccentColor,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                onPressed: () async {
                                  resetPassword();
                                },
                                child: Text(
                                  "Passwort zurücksetzen",
                                  style: TextStyle(color: themeProvider.isDarkMode
                                  ? Colors.white
                                      : Colors.black, fontSize: 15),
                                ),
                              )
                          )],))
              ]),
        )

    );
  }

  void resetPassword() async {
    try{
      FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      Utils.showSnackBar("Email has been sent");
    } on FirebaseException catch(e){
      Utils.showSnackBar(e.message);
    }
  }
}
