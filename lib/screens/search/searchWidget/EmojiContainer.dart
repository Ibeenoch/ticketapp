import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Emojicontainer extends StatelessWidget {
  const Emojicontainer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 25.w,
        height: 30.h,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10.r)),
        child: Text(
          text,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ));
  }
}
