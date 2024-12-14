import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';

class Tickettab extends StatefulWidget {
  final String leftText;
  final String rightText;

  const Tickettab({super.key, required this.leftText, required this.rightText});

  @override
  State<Tickettab> createState() => _TickettabState();
}

class _TickettabState extends State<Tickettab> {
  bool isLeft = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isLeft = true;
            });
          },
          child: Container(
            width: size.width * 0.43,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                color: isLeft ? AppStyles.cardBlueColor : Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Text(
              widget.leftText,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isLeft ? Colors.white : AppStyles.cardBlueColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              isLeft = false;
            });
          },
          child: Container(
            width: size.width * 0.43,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: isLeft ? Colors.white : AppStyles.cardBlueColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r))),
            child: Text(
              widget.rightText,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isLeft ? AppStyles.cardBlueColor : Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
