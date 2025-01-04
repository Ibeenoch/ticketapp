// ignore: file_names
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/currentMode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Halfcircular extends StatelessWidget {
  final bool isLeft;
  const Halfcircular({super.key, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10.w,
      height: 20.h,
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: isDarkMode(context)
                  ? AppStyles.backgroundColorBlue
                  : Colors.white,
              borderRadius: isLeft == true
                  ? BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r))
                  : BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r)))),
    );
  }
}
