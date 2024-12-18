import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerapp/AppRoutes.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/screens/account/authWidget/authBtn.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Page',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppStyles.textWhiteBlack(context)),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        backgroundColor: AppStyles.defaultBackGroundColor(context),
      ),
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: SafeArea(
          child: Column(children: [
        SizedBox(
          height: 30.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthBtn(
                text: 'Log In',
                func: () {
                  Navigator.pushNamed(context, AppRoutes.loginScreen);
                }),
            SizedBox(
              width: 15.w,
            ),
            AuthBtn(
              text: 'Sign Up',
              func: () {
                Navigator.pushNamed(context, AppRoutes.signupScreen);
              },
            )
          ],
        )
      ])),
    );
  }
}
