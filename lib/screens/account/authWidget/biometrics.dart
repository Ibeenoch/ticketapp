import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Biometrics extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
  final String text;
  final bool isEnabled;
  const Biometrics(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.text,
      this.isEnabled = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor:
                  AppStyles.backGroundColorWhiteAndDeepBlue(context),
              radius: 30.r,
              child: icon,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold,
                  color: isEnabled
                      ? Colors.green
                      : AppStyles.backGroundOfkakiIconContainer(context)),
            ),
          ],
        ),
      ),
    );
  }
}
