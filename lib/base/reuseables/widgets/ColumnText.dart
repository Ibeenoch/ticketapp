import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/widgets/cardTitle.dart';

class Columntext extends StatelessWidget {
  final String bigtext;
  final String smalltext;
  final TextAlign align;
  const Columntext(
      {super.key,
      required this.bigtext,
      required this.smalltext,
      this.align = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Cardtitle(
          // text: '1 May',
          text: bigtext,
          sizeType: 'h3',
          weightType: 'bold',
          align: align,
        ),
        Cardtitle(
          text: smalltext,
          sizeType: 'h4',
          align: align,
        ),
      ],
    );
  }
}
