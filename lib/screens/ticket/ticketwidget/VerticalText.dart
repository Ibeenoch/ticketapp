import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Verticaltext extends StatelessWidget {
  final String smallText;
  final String bigText;
  final TextAlign bigAlign;
  final TextAlign smallAlign;
  final CrossAxisAlignment columnAlign;
  const Verticaltext(
      {super.key,
      required this.smallText,
      required this.bigText,
      required this.smallAlign,
      required this.bigAlign,
      this.columnAlign = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: columnAlign == CrossAxisAlignment.end
          ? columnAlign
          : CrossAxisAlignment.start,
      children: [
        Text(
          bigText,
          style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          textAlign: bigAlign,
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          smallText,
          style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.normal,
              color: Colors.grey),
          textAlign: smallAlign,
        ),
      ],
    );
  }
}
