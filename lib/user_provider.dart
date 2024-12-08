import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  void updateEmail(email) {
    _email = email;
    notifyListeners();
  }

  void updatePassword(password) {
    _password = password;
    notifyListeners();
  }
}
