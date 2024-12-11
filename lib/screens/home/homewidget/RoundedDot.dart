import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';

class RoundedDot extends StatelessWidget {
  final bool showColor;
  const RoundedDot({super.key, this.showColor = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: showColor ? Colors.white : AppStyles.cardBlueColor,
            ),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
