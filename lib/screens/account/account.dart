// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/data/services/imageUploads.dart';
import 'package:airlineticket/base/reuseables/media/App_Media.dart';
import 'package:airlineticket/base/reuseables/resources/countries.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/loadingtextAnimation.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/account/authWidget/biometrics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? faceEncoding;
  String userId = '';
  bool isLoginTab = false;
  bool isBtnClickedLogin = false;
  bool isBtnClickedSignUp = false;
  // receive the user provider after it is called in the init state IG+TPc7P+0YgMqJIg/G5WwQuWiY=
  UserProvider? userProvider;
  final TextEditingController email = TextEditingController();
  final TextEditingController emailL = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordL = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController country = TextEditingController();

  Map<String, dynamic>? initialData;

  FocusNode emailF = FocusNode();
  FocusNode emailFL = FocusNode();
  FocusNode passwordF = FocusNode();
  FocusNode passwordFL = FocusNode();
  FocusNode bioF = FocusNode();
  FocusNode fullnameF = FocusNode();
  FocusNode addressF = FocusNode();
  FocusNode countryF = FocusNode();

  bool isPasswordVisible = false;
  String? fullnameError;
  String? bioError;
  String? addressError;
  String? emailError;
  String? emailErrorL;
  String? passwordError;
  String? passwordErrorL;
  String? countryError;
  String _selectedCountry = '';

  bool _isBottomSheetOpen = false;
  File? profileImg;
  String? networkImg;
  String generalError = '';
  String generalErrorS = '';

  @override
  void dispose() {
    email.dispose();
    emailL.dispose();
    password.dispose();
    passwordL.dispose();
    bio.dispose();
    fullname.dispose();
    address.dispose();
    country.dispose();
    super.dispose();
  }

  // add event listener when email is focus
  @override
  void initState() {
    super.initState();
// call the user Provider here
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        userProvider = Provider.of<UserProvider>(context, listen: false);
      });
    });

    emailF.addListener(() {
      if (!emailF.hasFocus) {
        validateEmail();
      }
    });

    emailFL.addListener(() {
      if (!emailFL.hasFocus) {
        validateEmailLogin();
      }
    });

    passwordF.addListener(() {
      if (!passwordF.hasFocus) {
        validatePassword();
      }
    });

    passwordFL.addListener(() {
      if (!passwordFL.hasFocus) {
        validatePasswordLogin();
      }
    });

    fullnameF.addListener(() {
      if (!fullnameF.hasFocus) {
        validateFullname();
      }
    });

    bioF.addListener(() {
      if (!bioF.hasFocus) {
        validateBio();
      }
    });

    addressF.addListener(() {
      if (!addressF.hasFocus) {
        validateAddress();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (ModalRoute.of(context)?.settings.arguments != null) {
      // retrieve arguments passed to this route
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, ParseUser?>;
      initialData = args['user']?.toJson();

      if (initialData != null) {
        //populate the text field
        setState(() {
          userId = initialData?['objectId'] ?? '';
          fullname.text = initialData?['fullname'] ?? '';
          bio.text = initialData?['bio'] ?? '';
          address.text = initialData?['address'] ?? '';
          _selectedCountry = initialData?['country'] ?? '';
          networkImg = initialData?['profile_img'] ?? '';
        });
      }
    }
  }

  void validateEmail() {
    final emailText = email.text.trim();
    if (emailText.isEmpty) {
      setState(() {
        emailError = 'Email is required';
      });
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(emailText)) {
      setState(() {
        emailError = 'Enter a valid email address';
      });
    } else {
      setState(() {
        emailError = null;
      });
    }
  }

  void validateEmailLogin() {
    final emailText = emailL.text.trim();
    if (emailText.isEmpty) {
      setState(() {
        emailErrorL = 'Email is required';
      });
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(emailText)) {
      setState(() {
        emailErrorL = 'Enter a valid email address';
      });
    } else {
      setState(() {
        emailErrorL = null;
      });
    }
  }

  Future<bool> _authenticateWithBiometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      final bool isAutheticated = await auth.authenticate(
          localizedReason: 'Please autheticate with biometrics to log in',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      return isAutheticated;
    } catch (e) {
      if (kDebugMode) {
        print('Error during biometric authetication $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during biometric authetication : $e'),
      ));
      return false;
    }
  }

  Future<void> _fetchUserProfile(String nameId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? fingerPrintId = prefs.getString(nameId);

      if (fingerPrintId == null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No $nameId found. Please enable biometrics first.'),
        ));
        return;
      }

      QueryBuilder<ParseUser> findFingerId =
          QueryBuilder<ParseUser>(ParseUser.forQuery());
      findFingerId.whereContains('fingerPrintId', fingerPrintId);

      final ParseResponse response = await findFingerId.query();

      if (response.success &&
          response.result != null &&
          response.result!.isNotEmpty) {
        // ParseObject userObject = response.results!.first as ParseObject;
        final ParseUser userObject = response.results!.first as ParseUser;

        // Step 3: Set the user in the provider
        Provider.of<UserProvider>(context, listen: false).setUser(userObject);

        // Navigate to user profile screen
        Navigator.pushNamed(context, AppRoutes.profileScreen);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user profile: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching user profile: $e'),
      ));
    }
  }

  void authWithFingerPrint() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isBiometricEnabled =
        prefs.getBool('isBiometricEnabled') ?? false;

    if (isBiometricEnabled) {
      final bool isAutheticated = await _authenticateWithBiometrics();
      if (isAutheticated) {
        // retrieve user profile and use provider to make it available globally
        await _fetchUserProfile('fingerPrintId');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Biometrics Authetication failed!'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Biometric authentication is not enabled!')),
      );
    }
  }

  void validatePassword() {
    final passwordText = password.text;
    if (passwordText.isEmpty) {
      setState(() {
        passwordError = 'Password is required';
      });
    } else if (passwordText.length < 8) {
      setState(() {
        passwordError = 'Password Length is too Short';
      });
    } else {
      setState(() {
        passwordError = null;
      });
    }
  }

  void validatePasswordLogin() {
    final passwordText = passwordL.text;
    if (passwordText.isEmpty) {
      setState(() {
        passwordErrorL = 'Password is required';
      });
    } else if (passwordText.length < 8) {
      setState(() {
        passwordErrorL = 'Password Length is too Short';
      });
    } else {
      setState(() {
        passwordErrorL = null;
      });
    }
  }

  void validateFullname() {
    final fullNameText = fullname.text;
    if (fullNameText.isEmpty) {
      setState(() {
        fullnameError = 'Full name is required';
      });
    } else {
      setState(() {
        fullnameError = null;
      });
    }
  }

  void validateAddress() {
    final addressText = address.text;
    if (addressText.isEmpty) {
      setState(() {
        addressError = 'Address is required';
      });
    } else {
      setState(() {
        addressError = null;
      });
    }
  }

  void validateBio() {
    final bioText = bio.text;
    if (bioText.isEmpty) {
      setState(() {
        bioError = 'bio is required';
      });
    } else {
      setState(() {
        bioError = null;
      });
    }
  }

  void _openBottomSheet(BuildContext context) async {
    setState(() {
      _isBottomSheetOpen = true;
    });
    final selectedCountry = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
        builder: (BuildContext context) {
          String? _currentSelectedCountry = _selectedCountry;
          return DraggableScrollableSheet(
              expand: false,
              builder: (_, scrollController) {
                return Container(
                  color: AppStyles.defaultBackGroundColor(context),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Text(
                        'Choose an option',
                        style: TextStyle(
                            color: AppStyles.textWhiteBlack(context),
                            fontSize: 12.sp),
                      ),
                      Expanded(
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: countries.length,
                              itemBuilder: (context, index) {
                                final country = countries[index];
                                return RadioListTile<String>(
                                    value: country,
                                    title: Text(country),
                                    groupValue: _currentSelectedCountry,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _currentSelectedCountry = value;
                                      });

                                      Navigator.pop(context, value);
                                    });
                              }))
                    ],
                  ),
                );
              });
        });

    if (selectedCountry != null) {
      setState(() {
        _selectedCountry = selectedCountry;
      });
    }

    setState(() {
      _isBottomSheetOpen = false;
    });
  }

  Future<void> handleSignUp() async {
    if (email.text.isEmpty &&
        password.text.isEmpty &&
        bio.text.isEmpty &&
        fullname.text.isEmpty &&
        address.text.isEmpty &&
        _selectedCountry.isEmpty) {
      setState(() {
        generalErrorS = 'please add all fields';
      });
      return;
    }
    try {
      setState(() {
        isBtnClickedSignUp = true;
        generalErrorS = '';
      });
      userProvider!.signUp(
          email: email.text,
          password: password.text,
          bio: bio.text,
          fullname: fullname.text,
          address: address.text,
          country: _selectedCountry,
          userImg: profileImg,
          context: context);
    } catch (e, stackTrace) {
      setState(() {
        isBtnClickedSignUp = false;
      });
      print('Error during sign-up: $e');
      print('Error occurred at: $stackTrace');
    }
  }

  Future<void> handleEditProfile() async {
    if (bio.text.isEmpty &&
        fullname.text.isEmpty &&
        address.text.isEmpty &&
        _selectedCountry.isEmpty) {
      setState(() {
        generalErrorS = 'please add all fields';
      });
      return;
    }
    print(
        'update user details ${bio.text} ${fullname.text} ${address.text} ${_selectedCountry}');
    try {
      setState(() {
        isBtnClickedSignUp = true;
        generalErrorS = '';
      });
      userProvider!.editProfile(
          userId: userId,
          fullname: fullname.text,
          bio: bio.text,
          address: address.text,
          selectedCountry: _selectedCountry,
          userImg: profileImg,
          context: context);
    } catch (e, stackTrace) {
      setState(() {
        isBtnClickedSignUp = false;
      });
      print('Error during edit: $e');
      print('Error occurred at: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void showLogin() {
      setState(() {
        isLoginTab = true;
      });
    }

    void showSignUp() {
      setState(() {
        isLoginTab = false;
      });
    }

    return Scaffold(
      backgroundColor: AppStyles.reversedefaultBackGroundColor(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Text(
              'RapidTik',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppStyles.textWhite(context),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.homePage);
              },
              child: SizedBox(
                width: 80.w,
                height: 80.h,
                child: const Image(image: AssetImage(AppMedia.companyLogo)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                authTabs(context, 'Login', showLogin, isLoginTab),
                authTabs(context, userId.isEmpty ? 'Sign Up' : 'Edit Profile',
                    showSignUp, !isLoginTab),
              ],
            ),
            isLoginTab
                ? Expanded(
                    child: Container(
                      color: AppStyles.defaultBackGroundColor(context),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          inputText(
                              context,
                              emailL,
                              emailFL,
                              'Enter your email address',
                              Icons.email,
                              false,
                              'Email'),
                          if (emailErrorL != null) errorMessage(emailErrorL!),
                          SizedBox(
                            height: 15.h,
                          ),
                          inputText(
                              context,
                              passwordL,
                              passwordFL,
                              'Enter your password',
                              Icons.lock,
                              true,
                              'Password'),
                          if (passwordErrorL != null)
                            errorMessage(passwordErrorL!),
                          SizedBox(
                            height: 10.h,
                          ),
                          forgotPassword(),
                          if (generalError.isNotEmpty)
                            errorMessage(generalError),
                          SizedBox(
                            height: 10.h,
                          ),
                          actonBtn(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Biometrics(
                                  onTap: authWithFingerPrint,
                                  icon: Icon(Icons.fingerprint,
                                      size: 30.w,
                                      color: AppStyles
                                          .backGroundOfkakiIconContainer(
                                              context)),
                                  text: 'Use Fingerprint'),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     loginWithGoogle();
                          //   },
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: 40.w),
                          //     child: Container(
                          //       alignment: Alignment.center,
                          //       padding: EdgeInsets.symmetric(
                          //           horizontal: 5.w, vertical: 10.h),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(7.r),
                          //         color: AppStyles.cardBlueColor,
                          //       ),
                          //       child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             SvgPicture.asset(
                          //               'assets/icons/google.svg',
                          //               width: 30.w,
                          //               height: 30.h,
                          //               // color: Colors.white,
                          //             ),
                          //             SizedBox(
                          //               width: 30.w,
                          //             ),
                          //             Text('Login with Google',
                          //                 style: TextStyle(
                          //                     fontSize: 13.sp,
                          //                     fontWeight: FontWeight.bold,
                          //                     color: Colors.white))
                          //           ]),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Stack(
                      children: [
                        ListView(
                          children: [
                            Container(
                              height: size.height,
                              color: AppStyles.defaultBackGroundColor(context),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    userProfile(),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    inputs(
                                        fullname,
                                        fullnameF,
                                        Icons.person,
                                        true,
                                        false,
                                        'Enter your first and last name ',
                                        fullnameError != null ? true : false,
                                        'FullName'),
                                    if (fullnameError != null)
                                      errorMessage(fullnameError!),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    inputs(
                                        address,
                                        addressF,
                                        Icons.location_city,
                                        true,
                                        false,
                                        'Enter your address',
                                        addressError != null ? true : false,
                                        'Address'),
                                    if (addressError != null)
                                      errorMessage(addressError!),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    inputs(
                                        bio,
                                        bioF,
                                        Icons.abc,
                                        true,
                                        false,
                                        'Tell us about yourself',
                                        bioError != null ? true : false,
                                        'Bio'),
                                    if (bioError != null)
                                      errorMessage(bioError!),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    userId.isNotEmpty
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              inputs(
                                                  email,
                                                  emailF,
                                                  Icons.email,
                                                  true,
                                                  false,
                                                  'Enter your email address',
                                                  emailError != null
                                                      ? true
                                                      : false,
                                                  'Email'),
                                              if (emailError != null)
                                                errorMessage(emailError!),
                                              SizedBox(
                                                height: 15.h,
                                              )
                                            ],
                                          ),
                                    userId.isNotEmpty
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              inputs(
                                                  password,
                                                  passwordF,
                                                  Icons.lock,
                                                  true,
                                                  true,
                                                  'Enter your password',
                                                  passwordError != null
                                                      ? true
                                                      : false,
                                                  'Password'),
                                              if (passwordError != null)
                                                errorMessage(passwordError!),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                            ],
                                          ),
                                    selectCountry(context),
                                    if (generalErrorS.isNotEmpty)
                                      errorMessage(generalErrorS!),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    actionBtn(),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        if (_isBottomSheetOpen)
                          Positioned.fill(
                              child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ))
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget authTabs(
      BuildContext context, String text, VoidCallback onTap, bool showBorder) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: showBorder
                ? Border(
                    bottom: BorderSide(
                        color: showBorder
                            ? Colors.white
                            : AppStyles.textWhiteBlack(context),
                        width: 3.w),
                  )
                : null),
        child: Container(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: showBorder ? Colors.white : AppStyles.textredBlue(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonAction(
      BuildContext context, VoidCallback onTap, String text, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: 130.w,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
              color: AppStyles.cardBlueColor),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputs(
    TextEditingController controller,
    FocusNode focus,
    IconData icon,
    bool showPrefixIcon,
    bool showSuffixIcon,
    String hintText,
    bool hasErr,
    String focusname,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: AppStyles.borderBackGroundColor(context),
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: StatefulBuilder(builder: (context, setState) {
          focus.addListener(() {
            setState(() {});
          });

          return Container(
            padding:
                EdgeInsets.only(left: 6.w, bottom: 8.h, right: 8.w, top: 0.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppStyles.defaultBackGroundColor(context),
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focus,
                    obscureText: isPasswordVisible && focusname == 'Password',
                    onChanged: (value) {
                      if (focusname == 'Email') {
                        validateEmail();
                      } else if (focusname == 'Password') {
                        validatePassword();
                      } else if (focusname == 'FullName') {
                        validateFullname();
                      } else if (focusname == 'Address') {
                        validateAddress();
                      } else if (focusname == 'Bio') {
                        validateBio();
                      } else {}
                    },
                    style: TextStyle(
                      fontSize: 8.sp,
                    ),
                    cursorColor: AppStyles.cardBlueColor,
                    decoration: InputDecoration(
                        hintText: focus.hasFocus ? '' : hintText,
                        hintStyle:
                            TextStyle(fontSize: 8.sp, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 9.h),
                        prefixIcon: showPrefixIcon
                            ? Icon(
                                icon,
                                size: 15.sp,
                                color: Colors.grey,
                              )
                            : null,
                        suffixIcon: showSuffixIcon
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 15.sp,
                                  color: Colors.grey,
                                ),
                              )
                            : null,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                                color: hasErr
                                    ? Colors.red
                                    : AppStyles.borderlineColor(context))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                BorderSide(color: AppStyles.cardBlueColor))),
                    autofillHints: null,
                  ),
                ),
              ),
              (focus.hasFocus) // display the label overlapping the top border
                  ? Positioned(
                      top: 3.h,
                      left: 20.w,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppStyles.defaultBackGroundColor(context)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            focusname,
                            style: TextStyle(
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ]),
          );
        }),
      ),
    );
  }

  Widget actionBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: InkWell(
        onTap: () async {
          try {
            userId.isNotEmpty ? handleEditProfile() : handleSignUp();
          } catch (e) {
            setState(() {
              isBtnClickedSignUp = false;
            });
          }
          // setState(() {
          //   isBtnClickedSignUp = false;
          // });
        },
        child: Container(
          width: double.infinity,
          height: 50.h,
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppStyles.cardBlueColor),
          child: Center(
              child: LoadingTextAnimation(
                  text: userId.isNotEmpty ? 'Edit Profile' : 'Sign Up',
                  isClicked: isBtnClickedSignUp)),
        ),
      ),
    );
  }

  Widget selectCountry(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppStyles.borderBackGroundColor(context)),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppStyles.defaultBackGroundColor(context)),
          child: TextField(
            controller: country,
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              hintText: _selectedCountry.length > 1
                  ? _selectedCountry
                  : 'Choose your country',
              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              prefixIcon: Icon(
                Icons.public,
                size: 12.sp,
                color: Colors.grey,
              ),
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onTap: () => _openBottomSheet(context),
          ),
        ),
      ),
    );
  }

  Widget userProfile() {
    return GestureDetector(
      onTap: () async {
        File img = await ImageStorage().uploadImage('gallery');
        setState(() {
          profileImg = img;
        });
      },
      child: Center(
        child: CircleAvatar(
            radius: 21.sp,
            backgroundColor: Colors.grey.shade200,
            child: profileImg == null
                ? Padding(
                    padding: EdgeInsets.all(1.sp),
                    child: CircleAvatar(
                      radius: 20.sp,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: networkImg != null
                          ? NetworkImage(networkImg ?? 'na')
                          : null,
                      child: networkImg == null || networkImg!.isEmpty
                          ? Icon(
                              Icons.person, // Default icon
                              size: 20.sp,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  )
                : CircleAvatar(
                    radius: 20.sp,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: Image.file(
                      profileImg!,
                      fit: BoxFit.contain,
                    ).image,
                  )),
      ),
    );
  }

  Widget inputText(
      BuildContext context,
      TextEditingController controller,
      FocusNode focus,
      String hintText,
      IconData icon,
      bool showRightIcon,
      String floatingTxt) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppStyles.borderBackGroundColor(context)),
      child: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppStyles.defaultBackGroundColor(context)),
                child: TextField(
                  controller: controller,
                  focusNode: focus,
                  autofillHints: null,
                  style: TextStyle(fontSize: 8.sp),
                  obscureText: isPasswordVisible && floatingTxt == 'Password',
                  onChanged: (value) {
                    if (floatingTxt == 'Email') {
                      validateEmailLogin();
                    } else {
                      validatePasswordLogin();
                    }
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                      border: InputBorder.none,
                      prefixIcon: Icon(icon, size: 13.sp, color: Colors.grey),
                      suffixIcon: showRightIcon
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              child: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 13.sp,
                                color: Colors.grey,
                              ),
                            )
                          : null,
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.sp),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: AppStyles.borderBackGroundColor(context))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              BorderSide(color: AppStyles.cardBlueColor))),
                  cursorColor: AppStyles.cardBlueColor,
                ),
              )),
          if (focus.hasFocus)
            Positioned(
                top: -1.h,
                left: 35.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      color: AppStyles.defaultBackGroundColor(context)),
                  child: Text(
                    floatingTxt,
                    style: TextStyle(fontSize: 7.sp),
                  ),
                ))
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'Forgot Password?',
          style: TextStyle(fontSize: 9.sp, color: AppStyles.cardBlueColor),
        ),
      ),
    );
  }

  Widget actonBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: GestureDetector(
        onTap: () async {
          final user = Provider.of<UserProvider>(context, listen: false);

          try {
            if (email.text.isEmpty && password.text.isEmpty) {
              setState(() {
                generalError = 'please add all fields';
                isBtnClickedLogin = false;
                return;
              });
            }
            setState(() {
              isBtnClickedLogin = true;
              generalError = '';
            });
            user.login(
                email: emailL.text, password: passwordL.text, context: context);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Login failed. something went wrong Please try again.')),
            );
            setState(() {
              isBtnClickedLogin = false;
            });
          }
        },
        child: Container(
            width: double.infinity,
            height: 45.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppStyles.cardBlueColor),
            child: LoadingTextAnimation(
                text: 'Login', isClicked: isBtnClickedLogin)),
      ),
    );
  }
}

Widget errorMessage(String err) {
  return Padding(
    padding: EdgeInsets.only(left: 18.w, top: 1.h),
    child: Row(
      children: [
        Icon(
          Icons.info,
          size: 10.sp,
          color: Colors.red,
        ),
        SizedBox(
          width: 3.w,
        ),
        Text(
          err,
          style: TextStyle(color: Colors.red, fontSize: 9.sp),
        ),
      ],
    ),
  );
}
