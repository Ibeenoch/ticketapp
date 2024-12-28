import 'package:airlineticket/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> loggedInUser(String username, String password) async {
    try {
      final ParseResponse response =
          await ParseUser(username, password, null).login();
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

  Future<void> initializeUser() async {
    _currentUser = await ParseUser.currentUser() as ParseUser;
    notifyListeners();
  }

  Future<void> logOut(context) async {
    try {
      final user = await ParseUser.currentUser() as ParseUser;
      var response = await user.logout();
      print('the respone logout status is $response, ${response.success}');
      if (response.success) {
        _currentUser = null;
        // await ParseUser.currentUser() = null;

        // Optionally, clear any other persistent data (e.g., SharedPreferences)
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('fingerPrintId'); // Example of clearing saved data
        await prefs.remove('isBiometricEnabled');
        await prefs.remove('faceId');
        await prefs.remove('isFaceRecognitionEnabled');

        print('Logout successful!');
        notifyListeners();
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
