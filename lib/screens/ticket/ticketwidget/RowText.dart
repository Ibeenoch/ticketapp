import 'package:airlineticket/screens/ticket/ticketwidget/VerticalText.dart';
import 'package:flutter/material.dart';

class Rowtext extends StatelessWidget {
  final String bigTextLeft;
  final String smallTextLeft;
  final String bigTextRight;
  final String smallTextRight;
  const Rowtext(
      {super.key,
      required this.bigTextLeft,
      required this.smallTextLeft,
      required this.bigTextRight,
      required this.smallTextRight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Verticaltext(
            bigText: bigTextLeft,
            smallText: smallTextLeft,
            smallAlign: TextAlign.start,
            bigAlign: TextAlign.start),
        Verticaltext(
          bigText: bigTextRight,
          smallText: smallTextRight,
          smallAlign: TextAlign.end,
          bigAlign: TextAlign.end,
          columnAlign: CrossAxisAlignment.end,
        ),
      ],
    );
  }
}
