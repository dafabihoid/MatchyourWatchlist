import 'package:flutter/cupertino.dart';
import 'package:watchlist/pages/WelcomePage.dart';

import 'LoginPage.dart';
import 'RegisterPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
            ? LoginPage(onClickedSignUp: toggle)
            : RegisterPage(onClickedSignIn: toggle);

  void toggle() => setState(() {
    isLogin = !isLogin;
  });
}

