import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class UserProvider extends ChangeNotifier {
  ParseUser? _currentUser;

  ParseUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<void> checkUserSession() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    try {
      if (user != null) {
        final ParseResponse response = await user.getUpdatedUser();
        if (response.success) {
          _currentUser = response.result;
          notifyListeners();
        } else {
          _currentUser = null;
        }
      } else {
        _currentUser = null;
      }
      notifyListeners();
    } catch (e) {
      _currentUser = null;
      notifyListeners();
    }
  }

  Future<bool> loggedInUser(String email, String password) async {
    try {
      final ParseResponse response =
          await ParseUser(email, password, null).login();
      if (response.success) {
        _currentUser = response.result as ParseUser;
        print('current logged in user: $_currentUser');

        notifyListeners();
        return true;
      } else {
        print('Error logging in: ${response.error?.message}');
        return false;
      }
    } catch (e) {
      print('Exception during login: $e');
      return false;
    }
  }

  Future<void> setUser(ParseUser user) async {
    _currentUser = user;
    await user.save();
    notifyListeners();
  }

  void logOut() async {
    try {
      final user = await ParseUser.currentUser() as ParseUser;
      var response = await user.logout();
      if (response.success) {
        _currentUser = null;
        notifyListeners();
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
