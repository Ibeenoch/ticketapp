// ignore: file_names
import 'dart:io';

import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/data/services/authetication.dart';
import 'package:flutter/foundation.dart';
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
        // Step 2: Upload the user's profile image (if provided)
        String? profileImageUrl;
        if (userImg != null && await userImg.exists()) {
          profileImageUrl = await Authentication().uploadProfileImage(userImg);
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
          // ignore: use_build_context_synchronously
          context,
          AppRoutes.profileScreen,
          arguments: {'userId': user.objectId!},
        );
      } else {
        if (kDebugMode) {
          print('Error while registering user: ${response.error?.message}');
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error during sign-up: $e');
      }
      if (kDebugMode) {
        print('Stack trace: $stackTrace');
      }
    }
  }

  Future<void> editProfile({
    required String userId,
    required String fullname,
    required String bio,
    required String address,
    required String selectedCountry,
    File? userImg,
    required context,
  }) async {
    try {
      String? profileImageUrl;
      if (userImg != null && await userImg.exists()) {
        profileImageUrl = await Authentication().uploadProfileImage(userImg);
        var user = ParseObject('_User')
          ..objectId = userId
          ..set('fullname', fullname)
          ..set('bio', bio)
          ..set('address', address)
          ..set('country', selectedCountry)
          ..set('profile_img', profileImageUrl);
        final response = await user.save();

        if (response.success) {
          final userz = await ParseUser.currentUser() as ParseUser?;
          if (userz != null) {
            final ParseResponse response = await userz.getUpdatedUser();
            if (response.success) {
              _currentUser = response.result;
              notifyListeners();
              Navigator.pushNamed(
                context,
                AppRoutes.profileScreen,
                arguments: {'userId': userId},
              );
            }
          }
        } else {
          if (kDebugMode) {
            print('Error updating profile: ${response.error?.message}');
          }
        }
      } else {
        var user = ParseObject('_User')
          ..objectId = userId
          ..set('fullname', fullname)
          ..set('bio', bio)
          ..set('address', address)
          ..set('country', selectedCountry);
        final response = await user.save();

        if (response.success) {
          final userz = await ParseUser.currentUser() as ParseUser?;
          if (userz != null) {
            final ParseResponse response = await userz.getUpdatedUser();
            if (response.success) {
              _currentUser = response.result;
              notifyListeners();
              Navigator.pushNamed(
                context,
                AppRoutes.profileScreen,
                arguments: {'userId': userId},
              );
            }
          }
        } else {
          if (kDebugMode) {
            print('Error updating profile: ${response.error?.message}');
          }
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error during edit: $e');
      }
      if (kDebugMode) {
        print('Error occurred at: $stackTrace');
      }
    }
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final String username = email;

      final user = ParseUser(username, password, null);

      var response = await user.login();
      if (response.success) {
        // final userProvider = Provider.of<UserProvider>(context, listen: false);
        final userdetails = response.result;

        setUser(userdetails as ParseUser);

        // Navigate to the profile page on successful login
        Navigator.pushNamed(
          // ignore: use_build_context_synchronously
          context,
          AppRoutes.profileScreen,
        );
      } else {
        // Show an error message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error logging user: $e');
      }
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
      if (response.success) {
        _currentUser = null;

        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during logout: $e');
      }
    }
  }
}
