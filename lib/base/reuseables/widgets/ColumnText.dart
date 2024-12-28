import 'package:airlineticket/base/reuseables/widgets/cardTitle.dart';
import 'package:flutter/material.dart';

class Columntext extends StatelessWidget {
  final String bigtext;
  final String smalltext;
  final TextAlign alignBig;
  final TextAlign alignsmall;
  final bool showColor;
  final bool hasWidth;
  final String alignSide;
  const Columntext(
      {super.key,
      required this.bigtext,
      required this.smalltext,
      this.alignBig = TextAlign.start,
      this.alignsmall = TextAlign.start,
      this.showColor = true,
      this.hasWidth = false,
      this.alignSide = 'center'});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignSide == 'start'
          ? CrossAxisAlignment.start
          : alignSide == 'end'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.center,
      children: [
        Cardtitle(
          // text: '1 May',
          text: bigtext,
          sizeType: 'h3',
          weightType: 'bold',
          align: alignBig,
          showColor: showColor,
          hasWidth: hasWidth,
        ),
        Cardtitle(
          text: smalltext,
          sizeType: 'h4',
          align: alignsmall,
          showColor: showColor,
          hasWidth: hasWidth,
        ),
      ],
    );
  }
}
