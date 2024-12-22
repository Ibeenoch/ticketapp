import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedDot extends StatelessWidget {
  final bool showColor;
  const RoundedDot({super.key, this.showColor = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.w),
      child: Container(
        width: 8.w,
        height: 8.h,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2.w,
              color: showColor ? Colors.white : AppStyles.cardBlueColor,
            ),
            borderRadius: BorderRadius.circular(20.r)),
      ),
    );
  }
}
