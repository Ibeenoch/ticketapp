import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/account/authWidget/authBtn.dart';
import 'package:airlineticket/screens/account/authWidget/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;
    print('the accont details $user');
    final profileImg = userProvider.currentUser?.get('profile_img');
    final fullname = userProvider.currentUser?.get('fullname');
    final email = userProvider.currentUser?.get('email');
    final address = userProvider.currentUser?.get('address');
    final bio = userProvider.currentUser?.get('bio');
    final country = userProvider.currentUser?.get('country');

    void navToHome() {
      Navigator.pushNamed(context, AppRoutes.homePage);
    }

    void logout() async {
      // UserProvider().logOut();
      Navigator.pushNamed(context, AppRoutes.loginScreen);
    }

    void editProfile() async {
      Navigator.pushNamed(context, AppRoutes.signupScreen, arguments: {
        'userId': user?.objectId,
        'fullname': user?.get<String>('fullname'),
        'bio': user?.get<String>('bio'),
        'address': user?.get<String>('address'),
        'country': user?.get<String>('country'),
        'profile_img': user?.get<String>('profile_img'),
      });
    }

    void addTicket() async {}

    return FutureBuilder(
        future: userProvider.checkUserSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: AppStyles.defaultBackGroundColor(context),
              body: Center(
                child: CircularProgressIndicator(
                  color: AppStyles.cardRedColor,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (userProvider.isLoggedIn) {
              return Scaffold(
                backgroundColor: AppStyles.defaultBackGroundColor(context),
                body: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        profileImg != null
                            ? Image.network(profileImg!)
                            : Icon(Icons.account_circle, size: 100.w),
                        SizedBox(height: 20.h),
                        Text('Full Name: $fullname',
                            style: TextStyle(fontSize: 13.sp)),
                        Text('Email: $email',
                            style: TextStyle(fontSize: 13.sp)),
                        Text('Address: $address',
                            style: TextStyle(fontSize: 13.sp)),
                        Text('Country: $country',
                            style: TextStyle(fontSize: 13.sp)),
                        Text('Bio: $bio', style: TextStyle(fontSize: 13.sp)),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buttonAction(
                                context, navToHome, 'Home Page', Icons.home),
                            SizedBox(
                              width: 10.h,
                            ),
                            buttonAction(
                                context, logout, 'Log Out', Icons.logout),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buttonAction(context, editProfile, 'Edit Profile',
                                Icons.edit),
                            SizedBox(
                              width: 10.h,
                            ),
                            buttonAction(
                                context, addTicket, 'Add Ticket', Icons.add),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: AppStyles.defaultBackGroundColor(context),
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthBtn(
                            text: 'Log In',
                            func: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.loginScreen);
                            },
                          ),
                          SizedBox(width: 15.w),
                          AuthBtn(
                            text: 'Sign Up',
                            func: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.signupScreen);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return const Scaffold(
            body: Center(child: Text('Something went wrong')),
          );
        });
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
}
