import 'dart:io';
import 'dart:ui';

import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/data/supabaseServices/authetication.dart';
import 'package:airlineticket/base/data/supabaseServices/imageUploads.dart';
import 'package:airlineticket/base/reuseables/media/App_Media.dart';
import 'package:airlineticket/base/reuseables/resources/countries.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/account/authWidget/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isLoginTab = true;
  final TextEditingController email = TextEditingController();
  final TextEditingController email_l = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController password_l = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController country = TextEditingController();

  Map<String, dynamic>? initialData;

  FocusNode email_f = FocusNode();
  FocusNode email_f_l = FocusNode();
  FocusNode password_f = FocusNode();
  FocusNode password_f_l = FocusNode();
  FocusNode bio_f = FocusNode();
  FocusNode fullname_f = FocusNode();
  FocusNode address_f = FocusNode();
  FocusNode country_f = FocusNode();

  bool isPasswordVisible = false;
  String? fullnameError;
  String? bioError;
  String? addressError;
  String? emailError;
  String? emailError_l;
  String? passwordError;
  String? passwordError_l;
  String? countryError;
  String _selectedCountry = '';
  String userId = '';
  bool _isBottomSheetOpen = false;
  File? profileImg;
  String? networkImg;

  @override
  void dispose() {
    email.dispose();
    email_l.dispose();
    password.dispose();
    password_l.dispose();
    bio.dispose();
    fullname.dispose();
    address.dispose();
    country.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // retrieve arguments passed to this route
    initialData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (initialData != null) {
      //populate the text field
      fullname.text = initialData?['fullname'] ?? '';
      bio.text = initialData?['bio'] ?? '';
      address.text = initialData?['address'] ?? '';
      _selectedCountry = initialData?['country'] ?? '';
      networkImg = initialData?['profile_img'] ?? '';
      userId = initialData?['userId'] ?? '';
    }
  }

  // add event listener when email is focus
  @override
  void initState() {
    super.initState();

    // print(' the data is ${widget.initialData} ');

    // email = TextEditingController(
    //   text: widget.initialData?['fullname']
    // )

    email_f.addListener(() {
      if (!email_f.hasFocus) {
        validateEmail();
      }
    });

    email_f_l.addListener(() {
      if (!email_f_l.hasFocus) {
        validateEmailLogin();
      }
    });

    password_f.addListener(() {
      if (!password_f.hasFocus) {
        validatePassword();
      }
    });

    password_f_l.addListener(() {
      if (!password_f_l.hasFocus) {
        validatePasswordLogin();
      }
    });

    fullname_f.addListener(() {
      if (!fullname_f.hasFocus) {
        validateFullname();
      }
    });

    bio_f.addListener(() {
      if (!bio_f.hasFocus) {
        validateBio();
      }
    });

    address_f.addListener(() {
      if (!address_f.hasFocus) {
        validateAddress();
      }
    });
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
    final emailText = email_l.text.trim();
    if (emailText.isEmpty) {
      setState(() {
        emailError_l = 'Email is required';
      });
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(emailText)) {
      setState(() {
        emailError_l = 'Enter a valid email address';
      });
    } else {
      setState(() {
        emailError_l = null;
      });
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
    final passwordText = password_l.text;
    if (passwordText.isEmpty) {
      setState(() {
        passwordError_l = 'Password is required';
      });
    } else if (passwordText.length < 8) {
      setState(() {
        passwordError_l = 'Password Length is too Short';
      });
    } else {
      setState(() {
        passwordError_l = null;
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
    try {
      Authentication().signUp(
          email: email.text,
          password: password.text,
          bio: bio.text,
          fullname: fullname.text,
          address: address.text,
          country: _selectedCountry,
          userImg: profileImg,
          context: context);
    } catch (e, stackTrace) {
      print('Error during sign-up: $e');
      print('Error occurred at: $stackTrace');
    }
  }

  Future<void> handleEditProfile() async {
    try {
      var user = ParseObject('_User')
        ..objectId = userId
        ..set('fullname', fullname.text)
        ..set('bio', bio.text)
        ..set('address', address.text)
        ..set('country', _selectedCountry);

      var response = await user.save();

      if (response.success) {
        print('editing user: ${response.result}');
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // final user = userProvider.currentUser;
    // print('the accont details $user');
    // final profileImg = userProvider.currentUser?.get('profile_img');
    // final fullname = userProvider.currentUser?.get('fullname');
    // final email = userProvider.currentUser?.get('email');
    // final address = userProvider.currentUser?.get('address');
    // final bio = userProvider.currentUser?.get('bio');
    // final country = userProvider.currentUser?.get('country');

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

    if (userProvider.isLoggedIn) {
      return Container(
        child: Text('user is logged in'),
      );
    } else {
      return Scaffold(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Text(
                'RapidTik',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
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
                  authTabs(context, 'Sign Up', showSignUp, !isLoginTab),
                ],
              ),
              isLoginTab
                  ? Expanded(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          inputText(
                              context,
                              email_l,
                              email_f_l,
                              'Enter your email address',
                              Icons.email,
                              false,
                              'Email'),
                          if (emailError_l != null) errorMessage(emailError_l!),
                          SizedBox(
                            height: 15.h,
                          ),
                          inputText(
                              context,
                              password_l,
                              password_f_l,
                              'Enter your password',
                              Icons.lock,
                              true,
                              'Password'),
                          if (passwordError_l != null)
                            errorMessage(passwordError_l!),
                          SizedBox(
                            height: 10.h,
                          ),
                          forgotPassword(),
                          SizedBox(
                            height: 10.h,
                          ),
                          actonBtn(),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Stack(
                        children: [
                          ListView(
                            children: [
                              Padding(
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
                                        fullname_f,
                                        Icons.person,
                                        true,
                                        false,
                                        'Enter your full name',
                                        fullnameError != null ? true : false,
                                        'FullName'),
                                    if (fullnameError != null)
                                      errorMessage(fullnameError!),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    inputs(
                                        address,
                                        address_f,
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
                                        bio_f,
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
                                    userId != null && userId.isNotEmpty
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              inputs(
                                                  email,
                                                  email_f,
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
                                    userId != null && userId.isNotEmpty
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              inputs(
                                                  password,
                                                  password_f,
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
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    actionBtn(),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
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
  }

  Widget authTabs(
      BuildContext context, String text, VoidCallback onTap, bool showBorder) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: showBorder!
                ? Border(
                    bottom: BorderSide(
                        color: showBorder
                            ? AppStyles.cardBlueColor
                            : AppStyles.textWhiteBlack(context),
                        width: 2.w),
                  )
                : null),
        child: Container(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: showBorder
                  ? AppStyles.cardBlueColor
                  : AppStyles.textWhiteBlack(context),
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
          userId != null && userId.isNotEmpty
              ? handleEditProfile()
              : handleSignUp();
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
            child: Text(
              userId != null && userId.isNotEmpty ? 'Edit Profile' : 'Sign Up',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: Colors.white),
            ),
          ),
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
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                      radius: 20.sp,
                      backgroundColor: Colors.grey.shade200,
                      child: Image(
                        image: networkImg != null && networkImg!.isNotEmpty
                            ? NetworkImage(networkImg!)
                            : AssetImage(AppMedia.user),
                        width: 20.sp,
                        height: 20.sp,
                        color: Colors.grey,
                      ),
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
          try {
            Authentication().login(
                email: email.text, password: password.text, context: context);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Login failed. something went wrong Please try again.')),
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: 45.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppStyles.cardBlueColor),
          child: Center(
            child: Text(
              'Log In',
              style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

Widget errorMessage(String err) {
  return Padding(
    padding: EdgeInsets.only(left: 18.w, top: 1.h),
    child: Text(
      err,
      style: TextStyle(color: Colors.red, fontSize: 8.sp),
    ),
  );
}
