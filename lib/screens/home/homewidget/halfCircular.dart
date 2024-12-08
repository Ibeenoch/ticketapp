import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/base/reuseables/widgets/currentMode.dart';

class Halfcircular extends StatelessWidget {
  final bool isLeft;
  const Halfcircular({super.key, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      height: 20,
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: isDarkMode(context)
                  ? AppStyles.backgroundColorBlue
                  : Colors.white,
              borderRadius: isLeft == true
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))
                  : const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)))),
    );
  }
}
