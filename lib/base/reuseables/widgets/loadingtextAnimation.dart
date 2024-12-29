import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingTextAnimation extends StatelessWidget {
  bool isClicked;
  String text;
  LoadingTextAnimation(
      {super.key, required this.text, required this.isClicked});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isClicked
          ? Container(
              width: 15.w,
              height: 15.w,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
    );
  }
}
