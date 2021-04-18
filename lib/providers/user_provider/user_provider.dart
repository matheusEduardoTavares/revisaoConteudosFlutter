import 'package:flutter/widgets.dart';
import 'package:projetocompleto2/models/user.dart';

class UserProvider with ChangeNotifier {
  User _user;

  void updateUser(User user) {
    _user = user;

    notifyListeners();
  }

  User get user => _user?.copyWith();
}