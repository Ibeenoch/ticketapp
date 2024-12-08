import 'package:flutter/material.dart';

class Applayoutbuilder extends StatelessWidget {
  const Applayoutbuilder({super.key, required this.randomWidthNum});
  // get random num
  final int randomWidthNum;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: List.generate(
            (constraints.constrainWidth() / randomWidthNum).floor(),
            (index) => const SizedBox(
                  width: 3,
                  height: 1,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white)),
                )),
      );
    });
  }
}
