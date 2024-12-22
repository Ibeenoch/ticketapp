import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Authentication {
  Future<void> signUp({
    required String email,
    required String password,
    required String bio,
    required String fullname,
    required String address,
    String country = 'Nigeria',
    File? userImg,
  }) async {
    try {
      /// Step 1: Register the user with email and password
      Future<void> registerUser() async {
        final user = ParseUser(email, password, email);

        final ParseResponse response = await user.signUp();

        if (response.success) {
          print('User registered successfully: ${response.result}');
          final ParseUser registeredUser = response.result;
          final String userId = registeredUser.objectId!;

          // Step 2: Upload the user's profile image
          final String? profileImageUrl =
              await uploadUserProfileImage(userId, userImg);
          print('the image url is: $profileImageUrl');
          // Step 3: Save the user profile details in the 'UserProfile' collection
          await saveUserProfile(
            userId: userId,
            email: email,
            bio: bio,
            fullname: fullname,
            address: address,
            country: country,
            profileImageUrl: profileImageUrl,
          );
        } else {
          print('Error while registering user: ${response.error?.message}');
        }
      }

      await registerUser();
    } catch (e, stackTrace) {
      print('Error during sign-up: $e');
      print('Error occurred at: $stackTrace');
    }
  }

  /// Step 2: Upload the user's profile image
  Future<String?> uploadUserProfileImage(String userId, File? userImg) async {
    if (userImg == null) {
      print('No profile image provided');
      return null;
    }

    final ParseFileBase parseFile =
        ParseFile(userImg, name: 'profile_$userId.jpg');

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
  Future<void> saveUserProfile({
    required String userId,
    required String email,
    required String bio,
    required String fullname,
    required String address,
    required String country,
    String? profileImageUrl,
  }) async {
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
      print('User profile saved successfully');
    } else {
      print('Error while saving user profile: ${response.error?.message}');
    }
  }
}
