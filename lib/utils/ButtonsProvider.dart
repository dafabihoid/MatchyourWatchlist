import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../DTOs/FriendsDTO.dart';
import '../backend/Controller.dart';


class ButtonsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool ButtonsActivated = false;

  void toggleButtons(bool test) {
    ButtonsActivated = test ? true : false;
    notifyListeners();
  }


}

