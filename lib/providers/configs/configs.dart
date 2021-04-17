import 'package:flutter/material.dart';

class Configs with ChangeNotifier {
  var appBrightness = Brightness.light;

  void changeTheme() {
    appBrightness = appBrightness == Brightness.dark ? 
      Brightness.light : Brightness.dark;

    notifyListeners();
  }
}