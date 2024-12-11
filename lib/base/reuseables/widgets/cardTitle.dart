import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';

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
      width: hasWidth ? 70 : null,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
            color: showColor ? color : Colors.black,
            fontSize: sizeType == 'h2'
                ? 16
                : sizeType == 'h3'
                    ? 12
                    : sizeType == 'h4'
                        ? 10
                        : 8,
            fontWeight:
                weightType == 'bold' ? FontWeight.bold : FontWeight.w400),
      ),
    );
  }
}
