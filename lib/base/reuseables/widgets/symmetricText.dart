import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/currentMode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Symmetrictext extends StatelessWidget {
  const Symmetrictext(
      {super.key,
      required this.bigText,
      required this.smallText,
      required this.func});
  final String bigText;
  final String smallText;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    bool isdarkMode = isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          bigText,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              color: isdarkMode ? Colors.white : Colors.black),
        ),
        InkWell(
          onTap: func,
          child: Row(
            children: [
              Text(
                smallText,
                style: AppStyles.h3(context),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: AppStyles.cardBlueColor,
                size: 17.sp,
              )
            ],
          ),
        )
      ],
    );
  }
}
