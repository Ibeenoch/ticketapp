import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Applayoutbuilder extends StatelessWidget {
  const Applayoutbuilder(
      {super.key, required this.randomWidthNum, this.showColor = true});
  // get random num
  final int randomWidthNum;
  final bool showColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: List.generate(
            (constraints.constrainWidth() / randomWidthNum).floor(),
            (index) => SizedBox(
                  width: 2.w,
                  height: 1.h,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: showColor
                              ? Colors.white
                              : AppStyles.cardBlueColor)),
                )),
      );
    });
  }
}
