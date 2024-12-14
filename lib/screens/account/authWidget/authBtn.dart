import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';

class AuthBtn extends StatelessWidget {
  const AuthBtn({super.key, required this.text, required this.func});
  final String text;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 42.w, vertical: 12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            color: AppStyles.cardBlueColor),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
