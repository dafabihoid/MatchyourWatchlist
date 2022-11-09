import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/SnackBar.dart';

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
    return Scaffold(
        appBar: AppBar(
        iconTheme: IconThemeData(
        color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Reset Password", style: TextStyle(color: Colors.black),),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Column(children: [
                        Image.asset("lib/assets/Logo.png",
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.3),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                            "Geben Sie eine Email ein, um ihr Passwort zurückzusetzen.",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                        const Text(
                            "Hinweis: Mail könnte im Spam-Ordner landen!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,

                            )),
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
                              color: Colors.black,
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
                              fillColor: const Color(0xFF0069FE),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              onPressed: () async {
                                resetPassword();
                              },
                              child: const Text(
                                "Passwort zurücksetzen",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            )),
                      ],)))
            ])

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
