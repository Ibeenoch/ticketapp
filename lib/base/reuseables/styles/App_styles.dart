import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/widgets/currentMode.dart';

Color primary = const Color(0xFF687daf);

//{colorScheme === 'light' ? 'bg-[#f7f7f7] border-t-[#0261ef]' : 'bg-[#0e1a32] border-t-[#ffd75b]
class AppStyles {
  // static Color primaryColor = primary;
  static Color textColor = const Color(0xFF3b3b3b);
  static Color bgColor = const Color(0xFFF4F4F4);

  static Color backgroundColorBlue = const Color(0xFF0E1A32);
  static Color backgroundColorwhite = const Color(0xFFF7F7F7);

  static Color primaryLightColor = const Color(0xFF0261EF);
  static Color primaryDarkColor = const Color(0xFFFFD75D);
  static Color cardBlueColor = const Color(0xFF526799);
  static Color cardRedColor = const Color(0xFFF37867);
  static Color kaki = const Color(0xFFd2bdb6);

  static Color primaryColor(BuildContext context) {
    return isDarkMode(context) ? primaryDarkColor : primaryLightColor;
  }

  static Color defaultBackGroundColor(BuildContext context) {
    return isDarkMode(context) ? Color(0xFF0E1A32) : Color(0xFFF7F7F7);
  }

  static Color textWhiteBlack(BuildContext context) {
    return isDarkMode(context) ? Colors.white : Colors.black;
  }

  static Color textWhite(BuildContext context) {
    return Colors.white;
  }

  static Color textGray(BuildContext context) {
    return isDarkMode(context) ? Colors.grey : Colors.grey;
  }

  static TextStyle h1(BuildContext context) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: textWhiteBlack(context),
    );
  }

  static TextStyle h4(BuildContext context) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: textWhiteBlack(context),
    );
  }

  static TextStyle h3(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: cardBlueColor,
    );
  }

  static TextStyle h3White(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: textWhite(context),
    );
  }

  static TextStyle h5(BuildContext context) {
    return TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: primaryColor(context));
  }

  static TextStyle h5White(BuildContext context) {
    return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textWhiteBlack(context));
  }
}
