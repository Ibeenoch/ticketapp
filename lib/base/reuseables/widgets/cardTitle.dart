import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cardtitle extends StatelessWidget {
  final String text;
  final String sizeType;
  final String weightType;
  final TextAlign align;
  final Color color;
  final bool hasWidth;
  final bool showColor;
  const Cardtitle(
      {super.key,
      required this.text,
      required this.sizeType,
      this.weightType = 'normal',
      this.align = TextAlign.start,
      this.color = Colors.white,
      this.hasWidth = true,
      this.showColor = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: hasWidth ? 82.w : null,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
            color: showColor ? color : Colors.black,
            fontSize: sizeType == 'h2'
                ? 14.sp
                : sizeType == 'h3'
                    ? 12.sp
                    : sizeType == 'h4'
                        ? 10.sp
                        : 8.sp,
            fontWeight:
                weightType == 'bold' ? FontWeight.bold : FontWeight.w300),
      ),
    );
  }
}
