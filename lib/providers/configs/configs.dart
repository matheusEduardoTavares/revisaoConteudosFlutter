import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projetocompleto2/providers/user_provider/user_provider.dart';
import 'package:projetocompleto2/utils/db_util.dart';

class Configs with ChangeNotifier {
  var appBrightness = Brightness.light;

  bool get isDarkTheme => appBrightness == Brightness.dark;

  Future<void> changeTheme([UserProvider provider]) async {
    appBrightness = appBrightness == Brightness.dark ? 
      Brightness.light : Brightness.dark;

    notifyListeners();

    final user = await DbUtil.getData();
    if (user != null && provider != null) {
      final newUser = user.copyWith(isDarkTheme: isDarkTheme);
      provider.updateUser(newUser);
      await DbUtil.updateData(newUser.toDbMap());
    }
  }

  void updateConfig(bool isDarkTheme) {
    appBrightness = isDarkTheme ? Brightness.dark : Brightness.light;

    notifyListeners();
  }
}