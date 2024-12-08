import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/base/reuseables/widgets/cardTitle.dart';

class Hoteltext extends StatelessWidget {
  final String text;
  final String weightType;
  final String sizeType;
  final Color color;
  const Hoteltext(
      {super.key,
      required this.text,
      this.weightType = 'bold',
      this.sizeType = 'h2',
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Cardtitle(
          text: text,
          sizeType: sizeType,
          weightType: 'bold',
          hasWidth: false,
          color: color,
        ),
      ),
    );
  }
}
