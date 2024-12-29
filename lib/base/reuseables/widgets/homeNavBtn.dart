import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeNavBtn extends StatelessWidget {
  const HomeNavBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.homePage);
      },
      child: Container(
        padding: EdgeInsets.only(right: 20.w),
        child: Icon(
          Icons.home,
          size: 24.sp,
          color: AppStyles.cardBlueColor,
        ),
      ),
    );
  }
}
