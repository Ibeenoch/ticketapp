import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/base/reuseables/widgets/currentMode.dart';

class Symmetrictext extends StatelessWidget {
  const Symmetrictext(
      {super.key,
      required this.bigText,
      required this.smallText,
      required this.func});
  final String bigText;
  final String smallText;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    bool isdarkMode = isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          bigText,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: isdarkMode ? Colors.white : Colors.black),
        ),
        InkWell(
          onTap: func,
          child: Row(
            children: [
              Text(
                smallText,
                style: AppStyles.h3(context),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: AppStyles.cardBlueColor,
                size: 17,
              )
            ],
          ),
        )
      ],
    );
  }
}
