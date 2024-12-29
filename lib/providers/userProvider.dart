import 'dart:io';

import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/data/services/authetication.dart';
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

  Future<void> signUp({
    required String email,
    required String password,
    required String bio,
    required String fullname,
    required String address,
    String country = 'Nigeria',
    File? userImg,
    required BuildContext context,
  }) async {
    try {
      // Step 1: Register the user with email and password
      final user = ParseUser(email, password, email);
      user.set<String>('fullname', fullname);
      user.set<String>('bio', bio);
      user.set<String>('address', address);
      user.set<String>('country', country);
      user.set<String>('profile_img', ''); // Placeholder for now

      // Create a new public ACL (Allow public read and write access)
      final ParseACL publicACL = ParseACL()
        ..setPublicReadAccess(allowed: true)
        ..setPublicWriteAccess(allowed: true);

      // Set the ACL for the user
      user.setACL(publicACL);

      final ParseResponse response = await user.signUp();

      if (response.success) {
        print('User registered successfully: ${response.result}');

        // Step 2: Upload the user's profile image (if provided)
        String? profileImageUrl;
        if (userImg != null && await userImg.exists()) {
          profileImageUrl = await Authentication().uploadProfileImage(userImg);
          print('Profile image uploaded: $profileImageUrl');
        } else {
          profileImageUrl =
              'https://via.placeholder.com/150/cccccc/ffffff?text=User';
        }

        // Update the user object with the profile image URL
        user.set<String>('profile_img', profileImageUrl!);
        await user.save();

        // Step 3: Set the user in the provider
        setUser(response.result as ParseUser);

        // Step 4: Navigate to the account screen
        Navigator.pushNamed(
          context,
          AppRoutes.profileScreen,
          arguments: {'userId': user.objectId!},
        );
      } else {
        print('Error while registering user: ${response.error?.message}');
      }
    } catch (e, stackTrace) {
      print('Error during sign-up: $e');
      print('Stack trace: $stackTrace');
    }
  }

  Future<void> editProfile({
    required String userId,
    required String fullname,
    required String bio,
    required String address,
    required String selectedCountry,
    required context,
  }) async {
    try {
      var user = ParseObject('_User')
        ..objectId = userId
        ..set('fullname', fullname)
        ..set('bio', bio)
        ..set('address', address)
        ..set('country', selectedCountry);

      var response = await user.save();

      if (response.success) {
        print('editing user: ${response.result}');
        setUser(response.result);
        Navigator.pushNamed(
          context,
          AppRoutes.accountScreen,
          arguments: {'userId': user.objectId!},
        );
      } else {
        print('Error updating profile: ${response.error?.message}');
      }
    } catch (e, stackTrace) {
      print('Error during edit: $e');
      print('Error occurred at: $stackTrace');
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
