import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerapp/base/reuseables/media/App_Media.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController country = TextEditingController();

  FocusNode email_f = FocusNode();
  FocusNode password_f = FocusNode();
  FocusNode bio_f = FocusNode();
  FocusNode fullname_f = FocusNode();
  FocusNode address_f = FocusNode();
  FocusNode country_f = FocusNode();

  bool isPasswordVisible = false;
  String? fullnameError;
  String? bioError;
  String? addressError;
  String? emailError;
  String? passwordError;
  String? countryError;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
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

    email_f.addListener(() {
      if (!email_f.hasFocus) {
        validateEmail();
      }
    });
    password_f.addListener(() {
      if (!password_f.hasFocus) {
        validatePassword();
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
      // emailError = null;
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
    final selectedCountry = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (BuildContext context) {
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
                          child: ListView(
                        controller: scrollController,
                        children: [
                          _buildOption(context, 'Nigeria'),
                          _buildOption(context, 'Ghana'),
                          _buildOption(context, 'Togo'),
                          _buildOption(context, 'kenya'),
                        ],
                      ))
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
        ),
        centerTitle: true,
        backgroundColor: AppStyles.defaultBackGroundColor(context),
      ),
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            child: Image(
                width: 150.w,
                height: 100.h,
                image: AssetImage(AppMedia.companyLogo)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
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
              if (fullnameError != null) errorMessage(fullnameError!),
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
              if (addressError != null) errorMessage(addressError!),
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
              if (bioError != null) errorMessage(bioError!),
              SizedBox(
                height: 15.h,
              ),
              inputs(
                  email,
                  email_f,
                  Icons.email,
                  true,
                  false,
                  'Enter your email address',
                  emailError != null ? true : false,
                  'Email'),
              if (emailError != null) errorMessage(emailError!),
              SizedBox(
                height: 15.h,
              ),
              inputs(
                  password,
                  password_f,
                  Icons.lock,
                  true,
                  true,
                  'Enter your password',
                  passwordError != null ? true : false,
                  'Password'),
              if (passwordError != null) errorMessage(passwordError!),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppStyles.borderBackGroundColor(context)),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppStyles.defaultBackGroundColor(context)),
                    child: TextField(
                      controller: country,
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 3.h),
                        hintText: 'Choose your country',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.public,
                          size: 12.sp,
                        ),
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onTap: () => _openBottomSheet(context),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              actionBtn(),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 17.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 10.sp,
                          color: AppStyles.textWhiteBlack(context)),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    Text(
                      'Log In',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 11.sp,
                          color: AppStyles.cardBlueColor),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      )),
    );
  }

  Padding actionBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 50.h,
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppStyles.cardBlueColor),
          child: Center(
            child: Text(
              'Sign Up',
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

  Padding errorMessage(String err) {
    return Padding(
      padding: EdgeInsets.only(left: 18.w, top: 1.h),
      child: Text(
        err,
        style: TextStyle(color: Colors.red, fontSize: 8.sp),
      ),
    );
  }

  Padding inputs(
    TextEditingController controller,
    FocusNode focus,
    IconData icon,
    bool showPrefixIcon,
    bool showSuffixIcon,
    String hintText,
    bool hasErr,
    String focusname,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: StatefulBuilder(builder: (context, setState) {
        focus.addListener(() {
          setState(() {});
        });

        return Container(
          padding:
              EdgeInsets.only(left: 8.w, bottom: 8.h, right: 8.w, top: 0.h),
          decoration: BoxDecoration(
              color: AppStyles.borderBackGroundColor(context),
              borderRadius: BorderRadius.circular(8.r)),
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppStyles.defaultBackGroundColor(context),
                ),
                child: TextField(
                  controller: controller,
                  focusNode: focus,
                  obscureText: isPasswordVisible,
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
                    fontSize: 12.sp,
                  ),
                  cursorColor: AppStyles.cardBlueColor,
                  decoration: InputDecoration(
                      hintText: focus.hasFocus ? '' : hintText,
                      hintStyle: TextStyle(fontSize: 10.sp, color: Colors.grey),
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
            (focus.hasFocus)
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
    );
  }
}

Widget _buildOption(BuildContext context, String option) {
  return ListTile(
    title: Text(option),
    onTap: () {
      Navigator.pop(context, option);
    },
  );
}
