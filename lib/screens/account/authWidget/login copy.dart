import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/data/supabaseServices/authetication.dart';
import 'package:airlineticket/base/reuseables/media/App_Media.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  FocusNode email_f = FocusNode();
  FocusNode password_f = FocusNode();

  String? emailError;
  String? passwordError;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose;
    super.dispose();
  }

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
  }

  void validateEmail() {
    final emailText = email.text;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log In',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppStyles.defaultBackGroundColor(context),
      ),
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: SafeArea(
          child: ListView(
        children: [
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
          SizedBox(
            height: 5.h,
          ),
          inputText(context, email, email_f, 'Enter your email address',
              Icons.email, false, 'Email'),
          if (emailError != null) errorMessage(emailError!),
          SizedBox(
            height: 15.h,
          ),
          inputText(context, password, password_f, 'Enter your password',
              Icons.lock, true, 'Password'),
          if (passwordError != null) errorMessage(passwordError!),
          forgotPassword(),
          SizedBox(
            height: 10.h,
          ),
          actonBtn(),
          switchScreen(context),
          SizedBox(
            height: 10.h,
          ),
        ],
      )),
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

  Widget switchScreen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(
                  fontSize: 8.sp, color: AppStyles.textWhiteBlack(context)),
            ),
            SizedBox(
              width: 5.w,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.signupScreen);
              },
              child: Text(
                "Sign Up",
                style:
                    TextStyle(fontSize: 9.sp, color: AppStyles.cardBlueColor),
              ),
            ),
          ],
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
                  obscureText: isPasswordVisible,
                  onChanged: (value) {
                    if (floatingTxt == 'Email') {
                      validateEmail();
                    } else {
                      validatePassword();
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
