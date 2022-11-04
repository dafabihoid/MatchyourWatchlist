import 'package:flutter/material.dart';

class Utils {
  static final SnackBarKey = GlobalKey<ScaffoldMessengerState>();

    static showSnackBar(String? text){

    if(text != null){
      final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red,);

      SnackBarKey.currentState!..removeCurrentSnackBar()..showSnackBar(snackBar);
    }
  }

}