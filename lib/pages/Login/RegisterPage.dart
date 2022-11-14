import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/utils/SnackBar.dart';
import 'package:watchlist/utils/Theme.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const RegisterPage({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    final formKey = GlobalKey<FormState>();
    String tmp_password = "";
    bool isPasswordVisible = true;
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    @override
    Widget build(BuildContext context) {
      return Container(
        //  color: isDarkTheme == true ? kDarkPrimaryColor : kLightPrimaryColor,
          height: double.infinity,
          padding: EdgeInsets.all(16),
          child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Column(children: [
                    SizedBox(height:65,),
                    Image.asset("lib/assets/Logo.png",
                        width: MediaQuery.of(context).size.width * 0.3),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("MatchYourWatchlist",
                        style: TextStyle(
                           // color: kLightPrimaryColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 50,
                    ),
                  ])),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.mail,
                    //color: kLightPrimaryColor,
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                email != null && !EmailValidator.validate(email)
                ? "Enter a valid email"
                : null,
              ),
              const SizedBox(
                height: 26,
              ),
              TextFormField(
                controller: _passwordController,
                onChanged: (value) => setState(() => tmp_password = value),
                decoration: InputDecoration(
                  hintText: "Passwort",
                  prefixIcon: const Icon(
                    Icons.vpn_key,
                 //   color: kLightPrimaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: isPasswordVisible
                        ? const Icon(
                      Icons.visibility_off,
                    //  color: kLightPrimaryColor,
                    )
                        : const Icon(
                      Icons.visibility,
                     // color: kLightPrimaryColor,
                    ),
                    onPressed: () => setState(
                            () => isPasswordVisible = !isPasswordVisible),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length <= 6
                ? "Gib mind. 6 Zeichen ein"
                : null,
                obscureText: isPasswordVisible,
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: kAccentColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    onPressed: () async {
                      signUp();

                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                    //    color: isDarkTheme == true ? kDarkPrimaryColor : kLightPrimaryColor,
                        fontSize: 18,
                      ),
                    ),
                  )),
              SizedBox(height: 10,),
              RichText(text: TextSpan(
                  style: TextStyle(color: kLightPrimaryColor, fontSize: 15),
                  text: 'Already have an Account? ',
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn,
                        text: 'Sign In',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.secondary
                        )
                    )
                  ]
              ))
            ],
          ))));
    }

  Future signUp() async{
      final isValid = formKey.currentState!.validate();
      if(!isValid) return;

      showDialog(context: context,barrierDismissible: false, builder: (context) => Center(child:CircularProgressIndicator()));
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      } on FirebaseAuthException catch (e){
        Utils.showSnackBar(e.message);
      }

      Navigator.of(context).pop();

  }
  }
