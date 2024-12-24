import 'dart:io';
import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class Authentication {
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

      final ParseResponse response = await user.signUp();

      if (response.success) {
        print('User registered successfully: ${response.result}');

        // Step 2: Upload the user's profile image (if provided)
        String? profileImageUrl;
        if (userImg != null && await userImg.exists()) {
          profileImageUrl = await uploadProfileImage(userImg);
          print('Profile image uploaded: $profileImageUrl');
        } else {
          profileImageUrl =
              'https://via.placeholder.com/150/cccccc/ffffff?text=User';
        }

        // Update the user object with the profile image URL
        user.set<String>('profile_img', profileImageUrl!);
        await user.save();

        // Step 3: Set the user in the provider
        Provider.of<UserProvider>(context, listen: false)
            .setUser(response.result as ParseUser);

        // Step 4: Navigate to the account screen
        Navigator.pushNamed(
          context,
          AppRoutes.accountScreen,
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

  /// Step 2: Upload the user's profile image
  ///
  Future<String?> uploadProfileImage(File imageFile) async {
    // Create a ParseFile instance from the image file
    final parseFile = ParseFile(imageFile);

    // Upload the file to Back4App
    final ParseResponse response = await parseFile.save();

    if (response.success) {
      // Return the uploaded file's URL
      return parseFile.url;
    } else {
      // Handle errors
      print('Error uploading file: ${response.error?.message}');
      return null;
    }
  }

  Future<String?> uploadUserProfileImage(File? userImg) async {
    if (userImg == null) {
      print('No profile image provided');
      return null;
    }
    final randomId = DateTime.now().microsecondsSinceEpoch.toString();

    final ParseFileBase parseFile =
        ParseFile(userImg, name: 'profile_$randomId.jpg');

    final ParseResponse response = await parseFile.save();

    if (response.success) {
      print('Profile image uploaded successfully ${parseFile.url}');
      return parseFile.url; // Return the URL of the uploaded image
    } else {
      print('Error while uploading profile image: ${response.error?.message}');
      return null;
    }
  }

  /// Step 3: Save user profile details in the 'UserProfile' collection
  Future<void> saveUserProfile(
      {required String userId,
      required String email,
      required String bio,
      required String fullname,
      required String address,
      required String country,
      String? profileImageUrl,
      required BuildContext context}) async {
    final parseObject = ParseObject('userProfile')
      ..set('userId', userId)
      ..set('email', email)
      ..set('bio', bio)
      ..set('fullname', fullname)
      ..set('address', address)
      ..set('country', country)
      ..set('profile_img', profileImageUrl);

    final ParseResponse response = await parseObject.save();

    if (response.success) {
      // save User to the provider
      Provider.of<UserProvider>(context, listen: false)
          .setUser(response.result as ParseUser);

      print('User profile saved successfully');
    } else {
      print('Error while saving user profile: ${response.error?.message}');
    }
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      bool success = await UserProvider().loggedInUser(email, password);
      if (success) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final userdetails = userProvider.currentUser;
        print('login user details is $userdetails');

        // Navigate to the profile page on successful login
        Navigator.pushNamed(
          context,
          AppRoutes.accountScreen,
        );
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      print('Error logging user: $e');
    }
  }
}
